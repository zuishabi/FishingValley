class_name PlayerStats
extends Stats

signal mana_changed

@export var base_max_endurance:float
@export var base_force:float
@export var base_max_mana:int

var current_max_endurance:float
var current_force:float
var main_skill:Skill
var passive_skills:Array[Skill]
var current_mana:int:
	set(value):
		current_mana=value
		mana_changed.emit(value,base_max_mana)

func reload():
	super.reload()
	if main_skill!= null:
		main_skill.use_time -= 1
		if main_skill.use_time == 0:
			print("已清除玩家主要技能")
			main_skill = null
	for i in passive_skills:
		i.use_time -= 1
		if i.use_time == 0:
			print("已清除玩家被动技能")
			passive_skills.erase(i)
	current_mana=base_max_mana
	current_force=base_force
	current_max_endurance=base_max_endurance

func add_skill(skill:Skill)->bool:
	if skill.type == Skill.SKILLTYPE.MAIN:
		if main_skill != null:
			return false
		else:
			main_skill = skill
			return true
	else:
		passive_skills.append(skill)
		return true
