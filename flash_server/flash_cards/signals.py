from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from .models import Card, Topic

@receiver(post_save, sender=Card)
def increment_num_cards(sender, instance, created, **kwargs):
    if created:
        instance.topic.num_cards += 1
        instance.topic.save()

@receiver(post_delete, sender=Card)
def decrement_num_cards(sender, instance, **kwargs):
    instance.topic.num_cards -= 1
    instance.topic.save()