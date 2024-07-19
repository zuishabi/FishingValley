extends Node

signal focus_changed
signal inventory_changed

var inventory:Array[BaseObject]
var focused_index:int=0:
	set(value):
		focused_index=value
		focus_changed.emit()

func _ready():
	inventory.resize(7)

func change_index(direction:int):
	focused_index=(focused_index+direction)%7

func add_item(object:BaseObject,amount:int=1)->bool:
	if(object==null):
		print("物品为空")
		return false
	else:
		if(object is Biat):
			return add_biat(object,amount)
		if(object is FishItem):
			return add_fish(object)
		elif(object is Tool):
			if(get_inventory_size()==7):
				return false
			var available_inventory:int=find_available_inventory()
			inventory[available_inventory]=object
			inventory_changed.emit(available_inventory)
			focus_changed.emit()
			return true
		return false

func add_biat(biat:Biat,amount:int)->bool:
	for i in inventory:
		if i is BiatBag:
			return i.add_item(biat,amount)
	return false

func add_fish(fish:FishItem)->bool:
	for i in inventory:
		if i is Bucket:
			return i.add_item(fish)
	return false

func get_inventory_size()->int:
	var current_size:int=0
	for i in inventory:
		if i != null:
			current_size+=1
	return current_size

func find_available_inventory()->int:
	for i in inventory.size():
		if inventory[i]==null:
			return i
	return -1
