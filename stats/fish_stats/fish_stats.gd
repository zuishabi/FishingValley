class_name FishStats
extends Stats

@export var base_max_strength:float
@export var max_action_point:int

var current_max_strength:float
var current_progress:float
var current_action_point:int

func reload():
	super.reload()
	current_max_strength = base_max_strength
