# Standard Library Imports
import json
# Third-Party Imports
import PyPDF2
from rest_framework import generics, permissions, status
from rest_framework.parsers import MultiPartParser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.exceptions import TokenError
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.status import HTTP_200_OK, HTTP_400_BAD_REQUEST
# Django Imports
from django.conf import settings
from django.contrib.auth import authenticate, get_user_model
from django.db import transaction
from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt

# Application Imports
from flash_cards.hello import json_object
from flash_cards.models import Card, Choice, Topic
from flash_cards.serializer import (
    CardSerializer,
    ChoiceSerializer,
    CustomUserCreateSerializer,
    TopicSerializer,
)
from flash_cards.service import generate_openai_response, generate_question_from_pdf

# Get the Custom User model
CustomUser = get_user_model()

class LoginView(APIView):
    def post(self, request):
        username = request.data.get("username")
        password = request.data.get("password")
        print(password)
        user = authenticate(request, username=username, password=password)
        
        if user:
            print('here1')
            refresh = RefreshToken.for_user(user)
            
            response = Response({"message": "Login successful"}, status=status.HTTP_200_OK)
            response.set_cookie(
                key="access_token",
                value=str(refresh.access_token),
                httponly=True,
                secure=True,
                samesite='Lax',
                max_age=settings.SIMPLE_JWT['ACCESS_TOKEN_LIFETIME'].total_seconds()
            )
            response.set_cookie(
                key="refresh_token",
                value=str(refresh),
                httponly=True,
                secure=True,
                samesite='Lax',
                max_age=settings.SIMPLE_JWT['REFRESH_TOKEN_LIFETIME'].total_seconds()
            )
            return response
        return Response({"error": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)


class RefreshTokenView(APIView):
    def post(self, request):
        refresh_token = request.COOKIES.get("refresh_token")
        
        if not refresh_token:
            return Response({"error": "Refresh token missing"}, status=status.HTTP_401_UNAUTHORIZED)

        try:
            refresh = RefreshToken(refresh_token)
            access_token = refresh.access_token
            
            response = Response({"message": "Token refreshed"}, status=status.HTTP_200_OK)
            response.set_cookie(
                key="access_token",
                value=str(access_token),
                httponly=True,
                secure=True,
                samesite='Lax',
                max_age=settings.SIMPLE_JWT['ACCESS_TOKEN_LIFETIME'].total_seconds()
            )
            return response
        except TokenError:
            return Response({"error": "Invalid refresh token"}, status=status.HTTP_401_UNAUTHORIZED)


class LogoutView(APIView):
    def post(self, request):
        response = Response({"message": "Logged out successfully"}, status=status.HTTP_204_NO_CONTENT)
        response.delete_cookie("access_token")
        response.delete_cookie("refresh_token")
        return response


class RegisterView(generics.CreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserCreateSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        return Response({
            "user": {
                "id": user.id,
                "username": user.username,
                "email": user.email
            }
        }, status=status.HTTP_201_CREATED)
    

class TopicListCreateView(generics.ListCreateAPIView):
    queryset = Topic.objects.all()
    serializer_class = TopicSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        print(self.request.user.id)
        # Filter topics to only those owned by the authenticated user
        return Topic.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class TopicDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Topic.objects.all()
    serializer_class = TopicSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        # Ensure users can only manage their own topics
        return self.queryset.filter(user=self.request.user)
    
class CardListCreateView(generics.ListCreateAPIView):
    serializer_class = CardSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        topic_id = self.kwargs['topic_id']
        return Card.objects.filter(topic_id=topic_id, topic__user=self.request.user)

    def perform_create(self, serializer):
        topic_id = self.kwargs['topic_id']
        topic = Topic.objects.get(id=topic_id, user=self.request.user)
        serializer.save(topic=topic)


class CardDetailView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = CardSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Card.objects.filter(topic__user=self.request.user)

    def perform_destroy(self, instance):
        topic = instance.topic
        super().perform_destroy(instance)
        # Update num_cards in the associated topic
        topic.num_cards = topic.cards.count()
        topic.save()


class ChoiceListCreateView(generics.ListCreateAPIView):
    serializer_class = ChoiceSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        card_id = self.kwargs['card_id']
        return Choice.objects.filter(card_id=card_id, card__topic__user=self.request.user)

    def perform_create(self, serializer):
        card_id = self.kwargs['card_id']
        card = generics.get_object_or_404(Card, id=card_id, topic__user=self.request.user)
        serializer.save(card=card)


class ChoiceDetailView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ChoiceSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Choice.objects.filter(card__topic__user=self.request.user)

@csrf_exempt
def openai_answer_question(request):
    """
    Handles a request to generate a response using OpenAI.
    """
    def format_question_with_choices(question, choices):
        """
        Format the question and choices into the required format.
        """
        formatted_choices = ", ".join(
            f"({idx + 1}) {choice['answer']}" for idx, choice in enumerate(choices)
        )
        return f'Question: "{question}"\nChoices: {formatted_choices}'
    
    if request.method == "POST":
        try:
            # Parse JSON data from the request body
            data = json.loads(request.body.decode("utf-8"))
            # Validate the presence of `question` and `choices`
            question = data.get("question")
            choices = data.get("choices")

            if not question:
                return JsonResponse({"error": "Question is required."}, status=400)

            if not choices or not isinstance(choices, list):
                return JsonResponse({"error": "Choices must be a list."}, status=400)

            # Format the input for OpenAI
            user_input = format_question_with_choices(question, choices)

            # Generate response using OpenAI
            response = generate_openai_response(user_input)

            return JsonResponse({"response": response}, status=200)

        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON format."}, status=400)
        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    return JsonResponse({"error": "Invalid request method."}, status=405)

class PdfUploadView(APIView):
    parser_classes = [MultiPartParser]
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, pk, *args, **kwargs):
        # Fetch the topic by primary key and validate ownership
        topic = get_object_or_404(Topic, pk=pk, user=request.user)

        pdf_file = request.FILES.get('pdfFile')
        if not pdf_file:
            return Response({'message': 'No file uploaded.'}, status=HTTP_400_BAD_REQUEST)

        if not pdf_file.name.endswith('.pdf'):
            return Response({'message': 'Uploaded file is not a PDF.'}, status=HTTP_400_BAD_REQUEST)

        try:
            pdf_reader = PyPDF2.PdfReader(pdf_file)
            content = ''.join([page.extract_text() for page in pdf_reader.pages])
        except PyPDF2.errors.PdfReadError:
            return Response({'message': 'Invalid or corrupted PDF file.'}, status=HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({'message': f'Unexpected error reading PDF: {str(e)}'}, status=HTTP_400_BAD_REQUEST)

        try:
            # res = generate_question_from_pdf(content)
            data = json.loads(json_object)

            with transaction.atomic():
                questions_response = []

                for question_data in data["questions"]:
                    # Create a card
                    card = Card.objects.create(
                        topic=topic,
                        question=question_data["question"]
                    )

                    # Create choices and format for the response
                    choices = []
                    for choice_data in question_data["choices"]:
                        choice = Choice.objects.create(
                            card=card,
                            choice_id=choice_data["choice_id"],
                            answer=choice_data["answer"],
                            is_correct=choice_data["is_correct"]
                        )
                        # Add choice to the response structure
                        choices.append({
                            "id": choice.id,
                            "choice_id": choice.choice_id,
                            "answer": choice.answer,
                            "is_correct": choice.is_correct,
                        })

                    # Add question and its choices to the response
                    questions_response.append({
                        "id": card.id,
                        "question": card.question,
                        "choices": choices,
                        "created_at": card.created_at.isoformat(),
                        "updated_at": card.updated_at.isoformat(),
                    })

                # Update the number of cards for the topic
                topic.num_cards = topic.cards.count()
                topic.save()

            # Return the questions and choices
            return Response(questions_response, status=HTTP_200_OK)

        except json.JSONDecodeError:
            return Response({'message': 'Error processing questions from the PDF content.'}, status=HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({'message': f'Error creating cards and choices: {str(e)}'}, status=HTTP_400_BAD_REQUEST)