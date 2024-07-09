extends Node

@export var object_list:Dictionary

func find_object(object_name:String)->BaseObject:
	if(object_list.has(object_name)):
		var object:BaseObject=object_list[object_name]
		return object.object_duplicate()
	else:
		return null
