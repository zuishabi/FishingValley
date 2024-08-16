class_name BaseAi
extends Node

@export var cost:int
@export var action_name:String
@export var action_type:TYPE
@export var weight:int
@export var use_time:int

var fish_stats:FishStats

enum TYPE {CHANCED,CONDITIONED}

func _ready() -> void:
	fish_stats = BattleManager.current_fish.fish_stats

func can_use() -> bool:
	if fish_stats.current_action_point >= cost && BattleManager.fish_skill_time[action_name] != 0:
		return true
	else:
		return false

func effect():
	pass
