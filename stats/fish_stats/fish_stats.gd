class_name FishStats
extends Stats

@export var base_max_strength:float

var current_strength:float

func reload():
	super.reload()
	current_strength=base_max_strength
