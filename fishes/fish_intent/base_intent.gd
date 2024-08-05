class_name Intent
extends Resource

signal update_speed
signal update_length
signal update_direction

@export_range(0,1) var change_direction:float
@export var max_speed:float
@export var min_speed:float
@export var max_length:float
@export var min_length:float
@export var b_on_b:bool
@export var max_hp:float
@export_file() var skill_node:String

var current_direction:int=-1
var length:float
var target_speed:float
var current_hp:float

func update_intent():
	if(randf_range(0,1)>change_direction):
		current_direction=-current_direction
	target_speed=randf_range(min_speed,max_speed)
	length=randf_range(min_length,max_length)
	update_speed.emit(target_speed)
	update_length.emit(length)
	update_direction.emit(current_direction)
