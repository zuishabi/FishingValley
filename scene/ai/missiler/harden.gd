extends BaseAi

var buff:Buff = preload("res://battle_elements/buff/harden.tres")

func effect():
	fish_stats.add_buff(buff)
