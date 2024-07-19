class_name FishItem
extends Item

@export var max_weight:int
@export var min_weight:int
@export var base_value:int

var weight:int

func _update():
	weight=randi_range(min_weight,max_weight)
	value=base_value*weight
