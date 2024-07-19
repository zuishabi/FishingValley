class_name Intent
extends Resource

signal update_speed
signal update_length
signal skill_used
signal skill_end

@export_range(0,1) var change_direction:float
@export var max_speed:float
@export var min_speed:float
@export var max_length:float
@export var min_length:float
@export var b_on_b:bool
@export var max_hp:float

var current_direction:int=-1
var if_change_direction:bool
var direction_change_time:int=0
var length:float
var target_speed:float
var current_hp:float

func update_intent():
	if(randf_range(0,1)>change_direction):
		current_direction=-current_direction
		if_change_direction=true
		direction_change_time+=1
	else:
		if_change_direction=false
	target_speed=randf_range(min_speed,max_speed)
	length=randf_range(min_length,max_length)
	skill()
	fix()
	update_speed.emit(target_speed*current_direction)
	update_length.emit(length)

func fix():
	pass

func skill():
	pass
