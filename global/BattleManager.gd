extends Node

@onready var timer_1 = $Timers/Timer_1

var global_position:float
var size:float
var player_stats:PlayerStats
var current_fish:Fish
var final_loots:Array[Item]
var start_time:int
var end_time:int

signal battle_win
signal battle_lose
signal main_prepared

func load_fight(player:PlayerStats,fish:Fish):
	player_stats=player
	current_fish=fish

func start_fish():
	final_loots.clear()
	start_time=Time.get_ticks_msec()
	get_tree().change_scene_to_file("res://scene/battle.tscn")

func update_position(new_pos:float):
	global_position=new_pos

func get_timer(time:float)->Timer:
	timer_1.wait_time=time
	timer_1.start()
	return timer_1

func on_battle_win():
	end_time=Time.get_ticks_msec()
	var fish_item:FishItem=ObjectList.get_item(current_fish.fish_name)
	final_loots.append(fish_item)
	get_tree().change_scene_to_file("res://saved_scene/saved_main.tscn")
	await main_prepared
	battle_win.emit(fish_item)

func on_battle_lose():
	end_time=Time.get_ticks_msec()
	get_tree().change_scene_to_file("res://saved_scene/saved_main.tscn")
	await main_prepared
	battle_lose.emit()
