# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Administrator(models.Model):
    id = models.OneToOneField('Person', models.DO_NOTHING, db_column='ID', primary_key=True)  # Field name made lowercase.
    username = models.CharField(db_column='Username', unique=True, max_length=15)  # Field name made lowercase.
    password = models.CharField(db_column='Password', max_length=15)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Administrator'


class Claimer(models.Model):
    id = models.OneToOneField('Person', models.DO_NOTHING, db_column='ID', primary_key=True)  # Field name made lowercase.
    dateclaimed = models.DateField(db_column='DateClaimed')  # Field name made lowercase.
    timeclaimed = models.TimeField(db_column='TimeClaimed')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Claimer'


class Item(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=15)  # Field name made lowercase.
    color = models.CharField(db_column='Color', max_length=15, blank=True, null=True)  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=50, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Item'

class Itemtag(models.Model):
    tagid = models.ForeignKey('Tag', models.DO_NOTHING, db_column='TagID')
    itemid = models.ForeignKey('Item', models.DO_NOTHING, db_column='ItemID')

    class Meta:
        managed = False
        db_table = 'ItemTag'
        unique_together = (('tagid', 'itemid'),)  # Composite key workaround

class Location(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=100)  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=50, blank=True, null=True)  # Field name made lowercase.
    streetaddress = models.CharField(db_column='StreetAddress', max_length=50)  # Field name made lowercase.
    city = models.CharField(db_column='City', max_length=50)  # Field name made lowercase.
    state = models.CharField(db_column='State', max_length=50)  # Field name made lowercase.
    zipcode = models.IntegerField(db_column='Zipcode')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Location'


class Lostitem(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    datereported = models.DateField(db_column='DateReported')  # Field name made lowercase.
    timereported = models.TimeField(db_column='TimeReported')  # Field name made lowercase.
    administratorid = models.ForeignKey(Administrator, models.DO_NOTHING, db_column='AdministratorID')  # Field name made lowercase.
    reporterid = models.ForeignKey('Person', models.DO_NOTHING, db_column='ReporterID')  # Field name made lowercase.
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
    city = models.CharField(db_column='City', max_length=50)  # Field name made lowercase.
    state = models.CharField(db_column='State', max_length=50)  # Field name made lowercase.
    zipcode = models.IntegerField(db_column='Zipcode')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Person'


class Tag(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', unique=True, max_length=50)  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Tag'


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'
