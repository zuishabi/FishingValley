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
