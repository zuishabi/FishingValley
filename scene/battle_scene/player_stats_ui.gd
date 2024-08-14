extends Control

var player_stats:PlayerStats

@onready var stats_grid = $MainPanel/HBoxContainer/PlayerStatsContainer/StatsGrid
@onready var stats_description = $StatsDescription
@onready var player_stats_container = $MainPanel/HBoxContainer/PlayerStatsContainer
@onready var buff_container = $MainPanel/HBoxContainer/BuffContainer

func _ready():
	player_stats_container.show()
	buff_container.hide()
	player_stats = BattleManager.player_stats
	BattleManager.update_player_stats_ui.connect(update_stats_information)
	var id:int = 0
	for i in stats_grid.get_children():
		i.id = id
		id += 1
		i.mouse_enter.connect(show_stats_description)
		i.mouse_exit.connect(hide_stats_description)
	buff_container.init(player_stats)

func changed_container(id:int):
	if id == 0:
		buff_container.hide()
		player_stats_container.show()
	else:
		buff_container.show()
		player_stats_container.hide()

func update_stats_information():
	%StatsUnit.update_info(player_stats.base_attack,player_stats.current_attack)
	%StatsUnit2.update_info(player_stats.base_armor,player_stats.current_armor)
	%StatsUnit3.update_info(player_stats.base_force,player_stats.current_force)
	%StatsUnit4.update_info(player_stats.max_health)
	%StatsUnit5.update_info(player_stats.base_max_endurance,player_stats.current_max_endurance)

func show_stats_description(id:int):
	stats_description.update_description(stats_grid.get_child(id).description)
	stats_description.global_position = stats_grid.get_child(id).global_position + Vector2.DOWN*35

func hide_stats_description(id:int):
	stats_description.hide()

func _on_player_stats_pressed():
	changed_container(0)

func _on_buff_pressed():
	changed_container(1)
