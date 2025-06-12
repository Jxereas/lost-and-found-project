from django.shortcuts import render
from django.http import JsonResponse
import json
from .models import Administrator, Tag, Location, Lostitem
from django.views.decorators.csrf import csrf_exempt
from django.db.models import Q, F, FilteredRelation

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

@csrf_exempt
def searchLostItems(request): 
    if request.method != "POST":
        return JsonResponse({"error": "POST method required"}, status=400)

    try:
        data = json.loads(request.body)
    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON"}, status=400)

    item_name = data.get("itemName", "")
    tags = data.get("tags", [])
    location = data.get("location", "")
    reporter_first = data.get("reporterFirstName", "")
    reporter_last = data.get("reporterLastName", "")
    claimer_first = data.get("claimerFirstName", "")
    claimer_last = data.get("claimerLastName", "")
    reported_start = data.get("reportedStartDate", "")
    reported_end = data.get("reportedEndDate", "")
    claimed_start = data.get("claimedStartDate", "")
    claimed_end = data.get("claimedEndDate", "")
    claim_status = data.get("claimStatus", "")

    # Only use select_related for guaranteed non-null relationships
    lost_items = Lostitem.objects.select_related(
        "itemid", "locationid", "reporterid__personid"
    ).all()

    if item_name:
        lost_items = lost_items.filter(itemid__name__icontains=item_name)

    if location:
        lost_items = lost_items.filter(locationid__buildingname=location)

    if tags:
        lost_items = lost_items.filter(itemid__itemtag__tagid__name__in=tags).distinct()

    if reporter_first:
        lost_items = lost_items.filter(reporterid__personid__firstname__icontains=reporter_first)
    if reporter_last:
        lost_items = lost_items.filter(reporterid__personid__lastname__icontains=reporter_last)

    print(claim_status)

    # Skip these filters if claimerid is nullable
    if claim_status == "Y":
        lost_items = lost_items.filter(isclaimed='Y')
    elif claim_status == "N":
        lost_items = lost_items.filter(isclaimed='N')
    if claimer_first:
        lost_items = lost_items.filter(claimerid__personid__firstname__icontains=claimer_first)
    if claimer_last:
        lost_items = lost_items.filter(claimerid__personid__lastname__icontains=claimer_last)
    if claimed_start:
        lost_items = lost_items.filter(claimerid__dateclaimed__gte=claimed_start)
    if claimed_end:
        lost_items = lost_items.filter(claimerid__dateclaimed__lte=claimed_end)

    if reported_start:
        lost_items = lost_items.filter(reporterid__datereported__gte=reported_start)
    if reported_end:
        lost_items = lost_items.filter(reporterid__datereported__lte=reported_end)

    results = []
    for item in lost_items:
        if item.claimerid_id:
            claimer_data = {
                "firstName": item.claimerid.personid.firstname,
                "lastName": item.claimerid.personid.lastname,
                "dateClaimed": item.claimerid.dateclaimed.isoformat(),
            }
        else:
            claimer_data = {
                "firstName": None,
                "lastName": None,
                "dateClaimed": None,
            }

        results.append({
            "itemName": item.itemid.name,
            "description": item.itemid.description,
            "color": item.itemid.color,
            "location": item.locationid.buildingname,
            "reporter": {
                "firstName": item.reporterid.personid.firstname,
                "lastName": item.reporterid.personid.lastname,
                "dateReported": item.reporterid.datereported.isoformat(),
            },
            "claimer": claimer_data,
            "isClaimed": item.isclaimed,
        })

    return JsonResponse({"results": results})
