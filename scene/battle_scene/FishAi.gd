extends Node

func set_ai():
	var new_scene = BattleManager.current_fish.AI.instantiate()
	add_child(new_scene)
