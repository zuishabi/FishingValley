class_name Archiving
extends Resource

@export var player_position:Vector2
@export var face_direction:Vector2
@export var inventory:Array[BaseObject]

func _init():
	inventory.resize(7)
	player_position = Vector2(1482,318)
