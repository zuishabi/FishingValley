extends Node

func _ready() -> void:
	BattleManager.current_fish.fish_stats.attack.connect(on_attacked)

func on_attacked(value:int):
	var new_effect:Effect = Effect.new(Effect.TYPE.ATTACK,20)
	BattleManager.player_stats.process_effect(new_effect)
