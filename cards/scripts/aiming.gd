class_name Aiming
extends Card

var aiming_skill:Skill = preload("res://scene/skills/player_skills/test_skill/test_skill.tres")

func can_use()->bool:
	if super.can_use():
		if BattleManager.player_stats.main_skill == null:
			return true
		else:
			emit_tips.emit("已有技能")
			return false
	else:
		return false

func effect():
	BattleManager.player_stats.add_skill(aiming_skill.duplicate(1))
