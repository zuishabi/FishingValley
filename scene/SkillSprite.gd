extends Sprite2D

@onready var fish = $"../Fish"

func update_position():
	global_position=fish.global_position
