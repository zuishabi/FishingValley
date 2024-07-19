extends Node

@export var object_list:Dictionary

func find_object(object_name:String)->BaseObject:
	if(object_list.has(object_name)):
		var object:BaseObject=object_list[object_name]
		return object.object_duplicate()
	else:
		return null

func get_item(item_name:String,amount:int=1)->Item:
	if(object_list.has(item_name)):
		var new_item:Item=object_list[item_name].object_duplicate()
		new_item.amount=amount
		return new_item
	else:
		return null
