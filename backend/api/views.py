from django.shortcuts import render
from django.http import JsonResponse
from .models import Lostitemreport

# Create your views here.
def test_view(request):
    data = list(Lostitemreport.objects.values())  # SELECT * FROM administrator
    return JsonResponse(data, safe=False)
