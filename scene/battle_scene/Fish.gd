class_name FishArea
extends Area2D

@onready var fishing_container = $".."

func move(length:float):
	self.global_position.y=clampf(self.global_position.y+length,124,484)
	if(self.global_position.y==124||self.global_position.y==484&&fishing_container.current_intent.b_on_b):
		fishing_container.is_moving=false
