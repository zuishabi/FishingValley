class_name ForceUp
extends Card

func effect(player_stats:Stats):
	player_stats=player_stats as PlayerStats
	player_stats.current_force+=2
	emit_tips.emit("增加2点力量")
