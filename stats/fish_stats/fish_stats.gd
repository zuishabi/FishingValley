class_name FishStats
extends Stats

@export var base_max_strength:float

var current_max_strength:float

func reload():
	super.reload()
	current_max_strength=base_max_strength
