class_name B_ForceUp
extends Buff

func apply_buff(object:Stats,effect:Effect = null):
	if object is PlayerStats:
		object.current_force += 2
