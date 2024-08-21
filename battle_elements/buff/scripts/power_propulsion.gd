class_name B_PowerPropulsion
extends Buff

func apply_buff(object:Stats,effect:Effect = null):
	if object is FishStats:
		object.speed_multiplier += 0.5
