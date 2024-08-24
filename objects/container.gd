class_name BaseContainer
extends Tool

@export var max_size:int
@export var inventory:Array[Item]

func get_current_size()->int:
	var current_size:int=0
	for i in inventory:
		if i!=null:
			current_size+=1
	return current_size

func get_available_inventory()->int:
	for i in inventory.size():
		if inventory[i]==null:
			return i
	return -1
