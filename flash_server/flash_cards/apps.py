from django.apps import AppConfig


class FlashCardsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'flash_cards'

    def ready(self):
        import flash_cards.signals
    