class_name Fish
extends Resource

@export var fish_name:String
@export var fish_texture:Texture2D
@export var AI:PackedScene
@export var intent:Intent
@export var fish_stats:FishStats

func exist()->bool:
	return true
