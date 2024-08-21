extends BaseAi

var skill:Skill = preload("res://scene/skills/extra_skills/boom/boom.tres")

func can_use() -> bool:
	if super.can_use():
		if float(fish_stats.health) <= float(fish_stats.max_health) * 0.2:
			return true
		else:
			return false
	else:
		return false

func effect():
	fish_stats.add_skill(skill)
