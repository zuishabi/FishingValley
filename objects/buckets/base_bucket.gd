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
