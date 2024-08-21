class_name ActionPicker
extends Node

var fish_stats:FishStats
var min_cost:int
var chanced_actions:Array[BaseAi]
var conditioned_actions:Array[BaseAi]
var final_actions:Array[BaseAi]
var start_pos:Vector2 = Vector2(830,150)

func _ready() -> void:
	if !BattleManager.has_registered:
		print("no registed")
		BattleManager.register_fish_skill(self)
	else:
		print("has registed")
	fish_stats = BattleManager.current_fish.fish_stats
	fish_stats.current_action_point = fish_stats.max_action_point
	BattleManager.fish_turn.connect(process_action)
	get_initial_actions()
	print("初始化行为")
	print("chanced_actions")
	print(chanced_actions)
	print("conditioned_actions")
	print(conditioned_actions)
	process_conditioned_actions()
	print("处理条件行为")
	print(final_actions)
	if fish_stats.current_action_point > 0:
		process_chanced_actions()
		print("处理随机行为")
		print(final_actions)

func get_initial_actions():
	for i:BaseAi in get_children():
		if i.can_use():
			if i.action_type == BaseAi.TYPE.CHANCED:
				chanced_actions.append(i)
			elif i.action_type == BaseAi.TYPE.CONDITIONED:
				conditioned_actions.append(i)

func process_conditioned_actions():
	conditioned_actions.sort_custom(sort_ascending)
	for i in conditioned_actions:
		if i.can_use():
			final_actions.append(i)
			fish_stats.current_action_point -= i.cost
			BattleManager.fish_skill_time[i.action_name] -= 1

func process_chanced_actions():
	chanced_actions.sort_custom(cost_sort_ascending)
	if chanced_actions.size() != 0:
		min_cost = chanced_actions.front().cost
	var total_weight:int = 0
	for i:BaseAi in chanced_actions:
		total_weight += i.weight
	while (chanced_actions.size() > 0):
		var randi:int = randi_range(0,total_weight)
		EventBus.emit_test(["当前随机值",str(randi)," 当前总权值",str(total_weight)])
		for i:BaseAi in chanced_actions:
			randi -= i.weight
			if randi <= 0:
				final_actions.append(i)
				fish_stats.current_action_point -= i.cost
				chanced_actions.erase(i)
				if i.cost == min_cost && chanced_actions.size() != 0:
					min_cost = chanced_actions.front().cost
				if fish_stats.current_action_point < min_cost:
					return
				break

func process_action():
	final_actions.shuffle()
	for i:BaseAi in final_actions:
		var timer = get_tree().create_timer(1)
		i.effect()
		BattleManager.emit_fish_skill_info.emit(i.action_name)
		BattleManager.emit_info.emit(i.action_name,start_pos)
		BattleManager.update_buff_ui.emit()
		await timer.timeout
	BattleManager.fish_trun_end.emit()

func sort_ascending(a:BaseAi, b:BaseAi):
	if a.weight < b.weight:
		return true
	return false

func cost_sort_ascending(a:BaseAi,b:BaseAi):
	if a.cost > b.cost:
		return true
	return false
