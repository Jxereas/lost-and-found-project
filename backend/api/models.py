# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Administrator(models.Model):
    personid = models.OneToOneField('Person', models.DO_NOTHING, db_column='PersonID', primary_key=True)  # Field name made lowercase.
    username = models.CharField(db_column='Username', unique=True, max_length=15)  # Field name made lowercase.
    password = models.CharField(db_column='Password', max_length=15)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Administrator'


class Claimer(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    personid = models.ForeignKey('Person', models.DO_NOTHING, db_column='PersonID')  # Field name made lowercase.
    dateclaimed = models.DateField(db_column='DateClaimed')  # Field name made lowercase.
    timeclaimed = models.TimeField(db_column='TimeClaimed')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Claimer'


class Item(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=15)  # Field name made lowercase.
    color = models.CharField(db_column='Color', max_length=15, blank=True, null=True)  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=255, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Item'


class Itemtag(models.Model):
    tagid = models.ForeignKey('Tag', models.DO_NOTHING, db_column='TagID')  # Field name made lowercase.
    itemid = models.ForeignKey(Item, models.DO_NOTHING, db_column='ItemID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'ItemTag'
        unique_together = (('tagid', 'itemid')) # Composite key workaround


class Location(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    buildingname = models.CharField(db_column='BuildingName', max_length=20)  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=255, blank=True, null=True)  # Field name made lowercase.
    streetaddress = models.CharField(db_column='StreetAddress', max_length=50)  # Field name made lowercase.
    city = models.CharField(db_column='City', max_length=25)  # Field name made lowercase.
    state = models.CharField(db_column='State', max_length=15)  # Field name made lowercase.
    zipcode = models.CharField(db_column='Zipcode', max_length=9)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Location'


class Lostitem(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    administratorid = models.ForeignKey(Administrator, models.DO_NOTHING, db_column='AdministratorID')  # Field name made lowercase.
    reporterid = models.ForeignKey('Reporter', models.DO_NOTHING, db_column='ReporterID')  # Field name made lowercase.
    claimerid = models.ForeignKey(Claimer, models.DO_NOTHING, db_column='ClaimerID')  # Field name made lowercase.
    itemid = models.ForeignKey(Item, models.DO_NOTHING, db_column='ItemID')  # Field name made lowercase.
    locationid = models.ForeignKey(Location, models.DO_NOTHING, db_column='LocationID')  # Field name made lowercase.
    isclaimed = models.CharField(db_column='IsClaimed', max_length=1)  # Field name made lowercase.
    notes = models.CharField(db_column='Notes', max_length=255, blank=True, null=True)  # Field name made lowercase.
    last_seen = models.CharField(db_column='LastSeen', max_length=100, blank=True, null=True)
    class Meta:
        managed = False
        db_table = 'LostItem'


class Person(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    firstname = models.CharField(db_column='FirstName', max_length=15)  # Field name made lowercase.
    lastname = models.CharField(db_column='LastName', max_length=15)  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=30)  # Field name made lowercase.
    phone = models.CharField(db_column='Phone', max_length=15)  # Field name made lowercase.
    streetaddress = models.CharField(db_column='StreetAddress', max_length=50)  # Field name made lowercase.
    city = models.CharField(db_column='City', max_length=25)  # Field name made lowercase.
    state = models.CharField(db_column='State', max_length=15)  # Field name made lowercase.
    zipcode = models.CharField(db_column='Zipcode', max_length=9)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Person'


class Reporter(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    personid = models.ForeignKey(Person, models.DO_NOTHING, db_column='PersonID')  # Field name made lowercase.
    datereported = models.DateField(db_column='DateReported')  # Field name made lowercase.
    timereported = models.TimeField(db_column='TimeReported')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Reporter'


class Tag(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', unique=True, max_length=15)  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=75)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Tag'
