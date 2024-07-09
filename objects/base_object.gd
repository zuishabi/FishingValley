class_name BaseObject
extends Resource

@export var object_texture:Texture2D
@export var object_name:String
@export_multiline var object_description:String

func _update():
	pass

func object_duplicate()->BaseObject:
	var new_object:BaseObject=self.duplicate(true)
	new_object._update()
	return new_object
