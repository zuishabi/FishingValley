class_name B_Harden
extends Buff

func apply_buff(object:Stats,value:Effect = null):
	object.current_armor += 10
