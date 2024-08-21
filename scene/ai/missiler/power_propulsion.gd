extends BaseAi

var buff:Buff = preload("res://battle_elements/buff/power_propulsion.tres")

func effect():
	fish_stats.add_buff(buff)
