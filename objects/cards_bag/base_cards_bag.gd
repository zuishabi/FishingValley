class_name CardsBag
extends BaseContainer

func _update():
	inventory.resize(max_size)

func add_card(card:Card)->bool:
	if(get_current_size()==max_size):
		return false
	else:
		inventory[get_available_inventory()]=card
		return true

func find_item(card:Card) -> bool:
	for i:Card in inventory:
		if i != null && i.object_name == card.object_name:
			return true
	return false

func delete_item(card:Card):
	for i:Card in inventory:
		if i != null && i.object_name == card.object_name:
			inventory.erase(i)
