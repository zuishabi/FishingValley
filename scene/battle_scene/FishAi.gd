extends Node

func set_ai():
	var new_scene = BattleManager.current_fish.AI.instantiate()
	add_child(new_scene)

func process_actions():
	var i:ActionPicker = get_child(0)
	i.process_action()
