from django.db import models

from django.contrib.auth.models import AbstractUser
from django.core.exceptions import ValidationError
from django.conf import settings

class CustomUser(AbstractUser):
    email = models.EmailField(unique=True)

    def __str__(self):
        return self.username


class Topic(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.CASCADE, 
        related_name='topics'
    )
    subject = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    num_cards = models.PositiveIntegerField(default=0)
    def __str__(self):
        return f"{self.name} ({self.user.username})"
    
class Card(models.Model):
    topic = models.ForeignKey(
        Topic, 
        on_delete=models.CASCADE, 
        related_name='cards'
    )
    question = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Card for Topic: {self.topic.subject}"
    
class Choice(models.Model):
    card = models.ForeignKey(
        Card, 
        on_delete=models.CASCADE, 
        related_name='choices'
    )
    choice_id = models.PositiveSmallIntegerField()
    answer = models.TextField()
    is_correct = models.BooleanField(default=False)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['card', 'choice_id'], 
                name='unique_choice_per_card'
            ),
            models.CheckConstraint(
                check=models.Q(choice_id__in=[1, 2, 3, 4]),
                name='valid_choice_id'
            )
        ]

    def __str__(self):
        return f"Choice {self.choice_id} for Card: {self.card.question}"