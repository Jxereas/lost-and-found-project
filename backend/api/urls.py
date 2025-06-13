from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.loginView, name='login'),
    path('locations/', views.getLocations, name='locations'),
    path('tags/', views.getTags, name='tags'),
    path('tags-management/', views.getTagsManagement, name='tags'),
    path('tags/create/', views.createTag, name='create tag'),
    path('tags/update/', views.updateTag, name='update tag'),
    path('search-lost-items/', views.searchLostItems, name='search lost items'),
    path('lost-items/add/', views.addLostItem, name='Add lost item'),
    path("lost-items-summary/", views.lostItemsSummary, name='Lost item summary'),
    path("lost-items/<int:lost_item_id>/edit/", views.editLostItem, name='Edit lost item'),
    path("lost-items/<int:lost_item_id>/", views.getLostItemDetail, name="Get lost item detail"),
]
