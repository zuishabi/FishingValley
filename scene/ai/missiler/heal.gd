extends BaseAi

func can_use() -> bool:
	if super.can_use():
		if float(fish_stats.health) <= float(fish_stats.max_health) * 0.5:
			return true
		else:
			return false
	else:
		return false

func effect():
	var heal:Effect = Effect.new(Effect.TYPE.HEAL,10)
	fish_stats.process_effect(heal)
