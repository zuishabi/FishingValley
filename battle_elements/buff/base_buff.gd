class_name Buff
extends Resource

@export var use_time:int
@export var name:String
@export var texture:Texture2D
@export_multiline var description:String

func apply_effect(object:Stats,value:Effect=null):
	pass
