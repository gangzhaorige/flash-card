from django.urls import include, path

from flash_cards.views import CardDetailView, CardListCreateView, ChoiceDetailView, ChoiceListCreateView, LoginView, LogoutView, PdfUploadView, RefreshTokenView, RegisterView, TopicDetailView, TopicListCreateView, openai_answer_question, PdfUploadView

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path("login/", LoginView.as_view(), name="login"),
    path("refresh/", RefreshTokenView.as_view(), name="token_refresh"),
    path("logout/", LogoutView.as_view(), name="logout"),
    path('topics/', TopicListCreateView.as_view(), name='topic_list_create'),
    path('topics/<int:pk>/', TopicDetailView.as_view(), name='topic_detail'),
    path('topics/<int:topic_id>/cards/', CardListCreateView.as_view(), name='card_list_create'),
    path('topics/<int:topic_id>/cards/<int:pk>/', CardDetailView.as_view(), name='card_detail'),
    path('cards/<int:card_id>/choices/', ChoiceListCreateView.as_view(), name='choice_list_create'),
    path('cards/<int:card_id>/choices/<int:pk>/', ChoiceDetailView.as_view(), name='choice_detail'),
    path('openai-answer-question/', openai_answer_question, name='openai_answer_question'),
    path('topics/<int:pk>/upload-pdf/', PdfUploadView.as_view(), name='upload-pdf'),
]