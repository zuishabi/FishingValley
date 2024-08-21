extends Node

var player_stats:PlayerStats
var current_fish:Fish
var final_loots:Array[Item]
var start_time:int
var end_time:int
var cards_inventory:Array[Card]
var discard_hands:Array[Card]
var has_registered:bool	=false			#是否记录鱼类技能的使用情况

signal battle_win
signal battle_lose
signal main_prepared
signal update_player_stats_ui
signal update_buff_ui
signal update_skill_ui
signal fish_turn
signal fish_trun_start
signal fish_trun_end
signal emit_fish_skill_info(info:String)
signal emit_info(info:String,pos:Vector2)

var fish_skill_time:Dictionary

func register_fish_skill(action_picker:ActionPicker):
	has_registered = true
	for i:BaseAi in action_picker.get_children():
		fish_skill_time[i.action_name] = i.use_time

func load_fight(player:PlayerStats,fish:Fish):
	player_stats=player
	current_fish=fish

func start_fish():
	fish_skill_time.clear()
	final_loots.clear()
	start_time=Time.get_ticks_msec()
	cards_inventory=Inventory.get_card_inventory()
	get_tree().change_scene_to_file("res://scene/battle_scene/battle.tscn")

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
