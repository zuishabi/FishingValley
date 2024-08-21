extends BaseAi

func effect():
	BattleManager.player_stats.current_max_endurance -= 50
	BattleManager.update_player_stats_ui.emit()
