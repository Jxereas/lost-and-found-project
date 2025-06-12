from django.shortcuts import render
from django.http import JsonResponse
import json
from .models import Administrator
from django.views.decorators.csrf import csrf_exempt
from .serializers import LostItemCreateSerializer

@csrf_exempt
def loginView(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Only POST requests allowed'}, status=405)

    try:
        data = json.loads(request.body)
        username = data.get('username')
        password = data.get('password')

        if not username and not password:
            return JsonResponse({'error': 'Username and password are required.'}, status=400)

        if not username:
            return JsonResponse({'error': 'Username is required.'}, status=400)

        if not password:
            return JsonResponse({'error': 'Password is required.'}, status=400)

        try:
            # admin = Administrator.objects.get(username=username)
            admin = Administrator.objects.extra(
                where=["BINARY username = %s"],
                params=[username]
            ).get()
        except Administrator.DoesNotExist:
            return JsonResponse({'error': 'Invalid username.'}, status=401)

        if admin.password != password:
            return JsonResponse({'error': 'Invalid password.'}, status=401)

        request.session['admin_id'] = admin.personid.id

        return JsonResponse({
            'id': admin.personid.id, 
            'username': admin.username,
            'person': {
                'First Name': admin.personid.firstname,
                'Last Name': admin.personid.lastname,
                'Email': admin.personid.email,
                'Phone Number': admin.personid.phone,
                'Street Address': admin.personid.streetaddress,
                'City': admin.personid.city,
                'State': admin.personid.state,
                'Zipcode': admin.personid.zipcode,
            }
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
@csrf_exempt
def add_lost_item(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Only POST requests allowed'}, status=405)

    try:
        data = json.loads(request.body)
        serializer = LostItemCreateSerializer(data=data)
        if serializer.is_valid():
            lost_item = serializer.save()
            return JsonResponse({'success': True, 'lost_item_id': lost_item.id})
        else:
            return JsonResponse({'error': serializer.errors}, status=400)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)