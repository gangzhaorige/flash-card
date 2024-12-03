from rest_framework import serializers

from flash_cards.models import Card, Choice, CustomUser, Topic


class CustomUserCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['id', 'username', 'email', 'password']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        # Hash the password before saving the user
        user = CustomUser(
            username=validated_data['username'],
            email=validated_data['email']
        )
        user.set_password(validated_data['password'])
        user.save()
        return user

class TopicSerializer(serializers.ModelSerializer):
    num_cards = serializers.IntegerField(read_only=True)  # Include num_cards

    class Meta:
        model = Topic
        fields = ('id', 'user', 'subject', 'description', 'num_cards', 'created_at', 'updated_at')
        read_only_fields = ('id', 'created_at', 'updated_at', 'user', 'num_cards')


class ChoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Choice
        fields = ('id', 'choice_id', 'answer', 'is_correct')
        read_only_fields = ('id',)
        extra_kwargs = {
            'choice_id': {'required': True},
            'answer': {'required': True},
        }


class CardSerializer(serializers.ModelSerializer):
    choices = ChoiceSerializer(many=True, required=False)

    class Meta:
        model = Card
        fields = ('id', 'question', 'choices', 'created_at', 'updated_at')
        read_only_fields = ('id', 'created_at', 'updated_at')

    def create(self, validated_data):
        choices_data = validated_data.pop('choices', [])
        card = Card.objects.create(**validated_data)

        # Create choices if provided
        for choice_data in choices_data:
            Choice.objects.create(card=card, **choice_data)

        return card

    def update(self, instance, validated_data):
        choices_data = validated_data.pop('choices', [])
        instance.question = validated_data.get('question', instance.question)
        instance.save()

        # Update choices
        if choices_data:
            instance.choices.all().delete()  # Remove existing choices
            for choice_data in choices_data:
                Choice.objects.create(card=instance, **choice_data)

        return instance