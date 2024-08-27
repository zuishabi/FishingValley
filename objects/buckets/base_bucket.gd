class_name Bucket
extends BaseContainer

func _update():
	inventory.resize(max_size)

func add_item(item:FishItem,amount:int=1)->bool:
	if(get_current_size()!=max_size):
		inventory[get_available_inventory()]=item
		item.amount=amount
		return true
	else:
		return false

func find_item(fish:FishItem) -> bool:
	for i:FishItem in inventory:
		if i!=null && i.object_name == fish.object_name:
			return true
	return false

func delete_item(fish:FishItem):
	for i:FishItem in inventory:
		if i != null && i.object_name == fish.object_name:
			inventory.erase(i)
