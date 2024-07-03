extends Node

@export var fish_list:Dictionary

func find_fish(fish_name:String)->Fish:
	return fish_list[fish_name]
