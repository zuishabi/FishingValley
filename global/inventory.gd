extends Node

signal focus_changed
signal inventory_changed

var inventory:Array[BaseObject]
var focused_index:int=0:
	set(value):
		focused_index=value
		focus_changed.emit()
var current_size:int=-1

func _ready():
	inventory.resize(7)

func change_index(direction:int):
	focused_index=(focused_index+direction)%7

func add_item(object:BaseObject,amount=1)->bool:
	if(object==null):
		print("物品为空")
		return false
	else:
		if(object is Biat):
			for i in inventory:
				if(i is BiatBag):
					return i.add_item(object,amount)
			return false
		elif(object is Tool):
			if(current_size==7):
				return false
			inventory[current_size+1]=object
			current_size+=1
			inventory_changed.emit(current_size)
			focus_changed.emit()
			return true
		return false
