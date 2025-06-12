from django.shortcuts import render
from django.http import JsonResponse
import json
from .models import Administrator, Tag, Location
from django.views.decorators.csrf import csrf_exempt


@csrf_exempt
def loginView(request):
    if request.method != "POST":
        return JsonResponse({"error": "Only POST requests allowed"}, status=405)

    try:
        data = json.loads(request.body)
        username = data.get("username")
        password = data.get("password")

        if not username and not password:
            return JsonResponse(
                {"error": "Username and password are required."}, status=400
            )

        if not username:
            return JsonResponse({"error": "Username is required."}, status=400)

        if not password:
            return JsonResponse({"error": "Password is required."}, status=400)

        try:
            # admin = Administrator.objects.get(username=username)
            admin = Administrator.objects.extra(
                where=["BINARY username = %s"], params=[username]
            ).get()
        except Administrator.DoesNotExist:
            return JsonResponse({"error": "Invalid username."}, status=401)

        if admin.password != password:
            return JsonResponse({"error": "Invalid password."}, status=401)

        request.session["admin_id"] = admin.personid.id

        return JsonResponse(
            {
                "id": admin.personid.id,
                "username": admin.username,
                "person": {
                    "First Name": admin.personid.firstname,
                    "Last Name": admin.personid.lastname,
                    "Email": admin.personid.email,
                    "Phone Number": admin.personid.phone,
                    "Street Address": admin.personid.streetaddress,
                    "City": admin.personid.city,
                    "State": admin.personid.state,
                    "Zipcode": admin.personid.zipcode,
                },
            }
        )
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)


@csrf_exempt
def getLocations(request):
    if request.method != "GET":
        return JsonResponse({"error": "Only GET requests allowed"}, status=405)

    locations = list(Location.objects.values_list("buildingname", flat=True).distinct())
    return JsonResponse({"locations": locations})


@csrf_exempt
def getTags(request):
    if request.method != "GET":
        return JsonResponse({"error": "Only GET requests allowed"}, status=405)

    tags = list(Tag.objects.values_list("name", flat=True).distinct())
    return JsonResponse({"tags": tags})
