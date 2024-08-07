class_name PlayerStats
extends Stats

signal mana_changed

@export var base_max_endurance:float
@export var base_force:float
@export var base_max_mana:int

var current_max_endurance:float
var current_force:float
var current_mana:int:
	set(value):
		current_mana=value
		mana_changed.emit(value,base_max_mana)

func reload():
	super.reload()
	current_mana=base_max_mana
	current_force=base_force
	current_max_endurance=base_max_endurance
