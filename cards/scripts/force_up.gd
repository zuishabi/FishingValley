class_name C_ForceUp
extends Card

var buff:Buff = preload("res://battle_elements/buff/force_up.tres")

func effect():
	BattleManager.player_stats.add_buff(buff)
	emit_tips.emit("增加2点力量")
