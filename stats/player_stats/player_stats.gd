class_name PlayerStats
extends Stats

signal mana_changed

@export var base_max_endurance:float
@export var base_force:float
@export var base_max_mana:int

var current_max_endurance:float
var current_force:float
var current_skill:Skill
var current_mana:int:
	set(value):
		current_mana=value
		mana_changed.emit(value,base_max_mana)

func reload():
	super.reload()
	if current_skill!= null:
		current_skill.use_time -= 1
		if current_skill.use_time == 0:
			print("清除玩家技能")
			current_skill = null
	current_mana=base_max_mana
	current_force=base_force
	current_max_endurance=base_max_endurance

func add_skill(skill:Skill)->bool:
	if current_skill != null:
		return false
	else:
		current_skill = skill
		return true
