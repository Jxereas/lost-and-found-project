from django.shortcuts import render
from django.http import JsonResponse
import json
from django.utils import timezone
from .models import Administrator, Tag, Location, Lostitem, Itemtag, Item, Reporter, Person
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
def getTagsManagement(request):
    if request.method != "GET":
        return JsonResponse({"error": "Only GET requests allowed"}, status=405)

    tags = Tag.objects.all().values("id", "name", "description")
    return JsonResponse({"tags": list(tags)})

@csrf_exempt
def createTag(request):
    if request.method != "POST":
        return JsonResponse({"error": "Only POST requests allowed"}, status=405)

    try:
        data = json.loads(request.body)
        name = data.get("name", "").strip()
        description = data.get("description", "").strip()

        if not name or not description:
            return JsonResponse({"error": "Name and description are required"}, status=400)

        if Tag.objects.filter(name=name).exists():
            return JsonResponse({"error": "A tag with that name already exists"}, status=409)

        Tag.objects.create(name=name, description=description)
        return JsonResponse({"message": "Tag created successfully"})

    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON"}, status=400)

@csrf_exempt
def updateTag(request):
    if request.method != "POST":
        return JsonResponse({"error": "Only POST requests allowed"}, status=405)

    try:
        data = json.loads(request.body)
        tag_id = data.get("id")
        new_name = data.get("newName", "").strip()
        new_description = data.get("newDescription", "").strip()

        if not tag_id:
            return JsonResponse({"error": "Tag ID is required"}, status=400)

        try:
            tag = Tag.objects.get(id=tag_id)
        except Tag.DoesNotExist:
            return JsonResponse({"error": "Tag not found"}, status=404)

        if new_name and new_name != tag.name:
            if Tag.objects.filter(name=new_name).exclude(id=tag_id).exists():
                return JsonResponse({"error": "A tag with that new name already exists"}, status=409)
            tag.name = new_name

        if new_description:
            tag.description = new_description

        tag.save()
        return JsonResponse({"message": "Tag updated successfully"})

    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON"}, status=400)


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

@csrf_exempt
def addLostItem(request):
    if request.method != "POST":
        return JsonResponse({"error": "Only POST requests allowed"}, status=405)

    try:
        data = json.loads(request.body)

        admin_id = data.get("adminId")
        person_data = data.get("person")
        location_data = data.get("location")
        item_data = data.get("item")
        tag_ids = data.get("tagIds", [])

        if not (admin_id and person_data and location_data and item_data):
            return JsonResponse({"error": "Missing required fields"}, status=400)

        # Get or create Person
        person, _ = Person.objects.get_or_create(
            firstname=person_data["firstname"].strip(),
            lastname=person_data["lastname"].strip(),
            email=person_data["email"].strip(),
            phone=person_data["phone"].strip(),
            streetaddress=person_data["streetaddress"].strip(),
            city=person_data["city"].strip(),
            state=person_data["state"].strip(),
            zipcode=person_data["zipcode"].strip()
        )

        # Create Reporter
        now = timezone.localtime()
        reporter = Reporter.objects.create(
            personid=person,
            datereported=now.date(),
            timereported=now.time()
        )

        # Get or create Location
        location, _ = Location.objects.get_or_create(
            buildingname=location_data["buildingname"].strip(),
            description=location_data["description"].strip(),
            streetaddress=location_data["streetaddress"].strip(),
            city=location_data["city"].strip(),
            state=location_data["state"].strip(),
            zipcode=location_data["zipcode"].strip()
        )

        # Get or create Item
        item, _ = Item.objects.get_or_create(
            name=item_data["name"].strip(),
            color=item_data["color"].strip(),
            description=item_data["description"].strip()
        )

        # Create LostItem
        admin = Administrator.objects.get(personid=admin_id)
        lost_item = Lostitem.objects.create(
            administratorid=admin,
            reporterid=reporter,
            itemid=item,
            locationid=location,
            isclaimed='N',
            notes=item_data.get("notes", "").strip()
        )

        # Link Tags
        for tag_id in tag_ids:
            tag = Tag.objects.get(id=tag_id)
            Itemtag.objects.create(tagid=tag, itemid=item)

        return JsonResponse({"message": "Lost item successfully logged."})

    except Administrator.DoesNotExist:
        return JsonResponse({"error": "Invalid Administrator ID"}, status=404)
    except Tag.DoesNotExist:
        return JsonResponse({"error": "One or more tags not found"}, status=404)
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)

@csrf_exempt
def lostItemsSummary(request):
    if request.method != "GET":
        return JsonResponse({"error": "Only GET requests allowed"}, status=405)

    lost_items = Lostitem.objects.select_related(
        "itemid", "reporterid__personid"
    ).all()

    result = []
    for item in lost_items:
        result.append({
            "id": item.id,
            "itemName": item.itemid.name,
            "reporterName": f"{item.reporterid.personid.firstname} {item.reporterid.personid.lastname}",
            "dateReported": str(item.reporterid.datereported),
        })

    return JsonResponse(result, safe=False)

@csrf_exempt
def editLostItem(request, lost_item_id):
    # if request.method != "POST":
    #     return JsonResponse({"error": "Only POST requests allowed"}, status=405)

    try:
        data = json.loads(request.body)
        # Get LostItem instance
        lost_item = Lostitem.objects.get(id=lost_item_id)

        # === Update Reporter.Person ===
        person_data = data.get("person", {})
        person = lost_item.reporterid.personid
        person.firstname = person_data.get("firstName", person.firstname)
        person.lastname = person_data.get("lastName", person.lastname)
        person.email = person_data.get("email", person.email)
        person.phone = person_data.get("phone", person.phone)
        person.streetaddress = person_data.get("streetAddress", person.streetaddress)
        person.city = person_data.get("city", person.city)
        person.state = person_data.get("state", person.state)
        person.zipcode = person_data.get("zipcode", person.zipcode)
        person.save()

        # === Update Item ===
        item_data = data.get("item", {})
        item = lost_item.itemid
        item.name = item_data.get("name", item.name)
        item.color = item_data.get("color", item.color)
        item.description = item_data.get("description", item.description)
        item.save()

        # === Update LostItem Notes ===
        lost_item.notes = item_data.get("notes", lost_item.notes)
        lost_item.save()

        # === Update Location ===
        location_data = data.get("location", {})
        location = lost_item.locationid
        location.buildingname = location_data.get("buildingName", location.buildingname)
        location.description = location_data.get("description", location.description)
        location.streetaddress = location_data.get("streetAddress", location.streetaddress)
        location.city = location_data.get("city", location.city)
        location.state = location_data.get("state", location.state)
        location.zipcode = location_data.get("zipcode", location.zipcode)
        location.save()

        # === Remove Tags ===
        tags_to_remove = data.get("tagsToRemove", [])  # list of tag IDs
        for tag_id in tags_to_remove:
            Itemtag.objects.filter(itemid=item.id, tagid=tag_id).delete()

        return JsonResponse({"message": "Lost item updated successfully."})

    except Lostitem.DoesNotExist:
        return JsonResponse({"error": "Lost item not found"}, status=404)
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)

@csrf_exempt
def getLostItemDetail(request, lost_item_id):
    if request.method != "GET":
        return JsonResponse({"error": "Only GET requests allowed"}, status=405)

    try:
        lost_item = Lostitem.objects.select_related(
            "itemid", "reporterid__personid", "locationid"
        ).get(id=lost_item_id)

        tags = Itemtag.objects.filter(itemid=lost_item.itemid.id).select_related("tagid")

        return JsonResponse({
            "person": {
                "firstName": lost_item.reporterid.personid.firstname,
                "lastName": lost_item.reporterid.personid.lastname,
                "email": lost_item.reporterid.personid.email,
                "phone": lost_item.reporterid.personid.phone,
                "streetAddress": lost_item.reporterid.personid.streetaddress,
                "city": lost_item.reporterid.personid.city,
                "state": lost_item.reporterid.personid.state,
                "zipcode": lost_item.reporterid.personid.zipcode,
            },
            "item": {
                "name": lost_item.itemid.name,
                "color": lost_item.itemid.color,
                "description": lost_item.itemid.description,
                "notes": lost_item.notes,
            },
            "location": {
                "buildingName": lost_item.locationid.buildingname,
                "description": lost_item.locationid.description,
                "streetAddress": lost_item.locationid.streetaddress,
                "city": lost_item.locationid.city,
                "state": lost_item.locationid.state,
                "zipcode": lost_item.locationid.zipcode,
            },
            "tags": [
            ]
        })

    except Lostitem.DoesNotExist:
        return JsonResponse({"error": "Lost item not found"}, status=404)
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)
