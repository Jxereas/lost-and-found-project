from django.urls import path
from .views import loginView, add_lost_item

urlpatterns = [
    path('login/', loginView, name='login'),
    path('lostitems/', add_lost_item, name='add_lost_item'),
]
