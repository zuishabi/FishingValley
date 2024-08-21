class_name FishStats
extends Stats

@export var base_max_strength:float
@export var max_action_point:int

var current_max_strength:float
var current_progress:float
var current_action_point:int
var speed_multiplier:float
var extra_skills:Array[Skill]

func reload():
	super.reload()
	speed_multiplier = 1
	current_max_strength = base_max_strength
	update_skill()

func add_skill(skill:Skill):
	for i:Skill in extra_skills:
		if skill.skill_name == i.skill_name:
			i.use_time += skill.use_time
			break
	extra_skills.append(skill.duplicate())

func update_skill():
	for i in extra_skills:
		i.use_time -= 1
		if i.use_time == 0:
			extra_skills.erase(i)
