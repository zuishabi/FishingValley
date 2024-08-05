class_name Card
extends Item

enum TYPE {NROAML,SKILL,POLE}
enum TARGET {SELF,ENEMY}

signal emit_tips(content:String)

@export var cost:int
@export var card_type:TYPE
@export var use_time:int
@export var target:TARGET

func can_use(player_stats:PlayerStats)->bool:
	if player_stats.current_mana-cost >= 0:
		return true
	else:
		emit_tips.emit("法力值不足")
		return false

func effect(stats:Stats):
	pass
