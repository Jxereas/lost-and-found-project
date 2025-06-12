from rest_framework import serializers
from .models import Item, Lostitem, Itemtag
import datetime
class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = ['name', 'color', 'description']

class LostItemCreateSerializer(serializers.Serializer):
    item = ItemSerializer()
    tag_ids = serializers.ListField(child=serializers.IntegerField())
    admin_id = serializers.IntegerField()
    is_claimed = serializers.ChoiceField(choices=[('Y', 'Yes'), ('N', 'No')])
    last_seen = serializers.CharField()

    def create(self, validated_data):
        from .models import Location, Administrator
        try:
            item_data = validated_data.pop('item')
            tag_ids = validated_data.pop('tag_ids')
            last_seen = validated_data.pop('last_seen')
            is_claimed = validated_data.pop('is_claimed')
            admin_id = validated_data.pop('admin_id')

            item = Item.objects.create(**item_data)
            lost_item = Lostitem.objects.create(
                itemid=item,
                locationid_id=1, # TEMP: replace with a real reporter
                administratorid_id=admin_id,
                reporterid_id=1,  # TEMP: replace with a real reporter
                claimerid_id=1,   # TEMP: or set to None / handle optional
                isclaimed=is_claimed,
                last_seen=last_seen,
                datereported=datetime.date.today(),
                timereported=datetime.datetime.now().time(),   # TEMP: same with time
            )

            for tag_id in tag_ids:
                Itemtag.objects.create(itemid=item, tagid_id=tag_id)

            return lost_item

        except Exception as e:
            import traceback
            print(" ERROR in LostItemCreateSerializer.create():")
            traceback.print_exc()
            raise serializers.ValidationError("Server error when creating lost item.")
