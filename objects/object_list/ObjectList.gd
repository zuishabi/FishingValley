extends Node

@export var fishing_pole_list:Dictionary

func find_fish_pole(pole_name:String)->FishingPole:
	var pole:FishingPole=fishing_pole_list[pole_name]
	return pole.duplicate(true)
