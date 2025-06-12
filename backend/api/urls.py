from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.loginView, name='login'),
    path('locations/', views.getLocations, name='locations'),
    path('tags/', views.getTags, name='tags'),
    path('search-lost-items/', views.searchLostItems, name='search lost items'),
]
