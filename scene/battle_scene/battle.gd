class_name Battle
extends Node2D

#当前回合，如果为1则是钓鱼回合，0为卡牌回合
var current_round:int=0
var fishing_container=load("res://scene/battle_scene/fishing_container.tscn")
var card_scene=load("res://scene/battle_scene/card_scene.tscn")
var player_stats:PlayerStats
var fish_stats:FishStats

@onready var player_health = $BattleUI/PlayerHealth
@onready var fish_health = $BattleUI/FishHealth

func _ready():
	player_stats = BattleManager.player_stats as PlayerStats
	fish_stats = BattleManager.current_fish.fish_stats as FishStats
	player_health.max_value = player_stats.max_health
	fish_health.max_value =fish_stats.max_health
	player_stats.health_changed.connect(on_player_health_chaned)
	fish_stats.health_changed.connect(on_fish_health_changed)
	player_stats.health=player_stats.max_health
	fish_stats.health=fish_stats.max_health
	round_change(0)

func round_change(target_round:int):
	current_round=target_round
	if(target_round==1):
		var current_scene=get_tree().get_first_node_in_group("CardScene")
		if(current_scene != null):
			current_scene.queue_free()
		var new_scene=fishing_container.instantiate()
		add_child(new_scene)
	else:
		var current_scene=get_tree().get_first_node_in_group("FishingContainer")
		if(current_scene != null):
			current_scene.queue_free()
		var new_scene=card_scene.instantiate()
		add_child(new_scene)

func on_player_health_chaned(value:int):
	player_health.value = value

func on_fish_health_changed(value:int):
	fish_health.value = value
