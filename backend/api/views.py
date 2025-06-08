from django.shortcuts import render
from django.http import JsonResponse
from .models import Lostitem

# Create your views here.
def test_view(request):
    data = list(Lostitem.objects.values())  # SELECT * FROM administrator
    return JsonResponse(data, safe=False)
