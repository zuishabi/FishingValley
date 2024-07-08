extends Node

var player_stats:PlayerStats
var current_fish:Fish

func load_fight(player:PlayerStats,fish:Fish):
	player_stats=player
	current_fish=fish

func start_fisht():
	Ui.hide()
	get_tree().change_scene_to_file("res://scene/battle.tscn")
