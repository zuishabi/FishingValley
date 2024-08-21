extends PoleShape

var is_active:bool = false
var fishing_container:FishingContainer

func _ready():
	fishing_container=get_tree().get_first_node_in_group("FishingContainer")
	
func process():
	if is_active:
		return
	else:
		is_active = true
		BattleManager.current_fish.fish_stats.speed_multiplier -= 0.2
		EventBus.emit_test(["进入减速区域，当前速度倍率:",str(BattleManager.current_fish.fish_stats.speed_multiplier)])

func leave():
	is_active = false
	BattleManager.current_fish.fish_stats.speed_multiplier += 0.2
	EventBus.emit_test(["离开减速区域，当前速度倍率:",str(BattleManager.current_fish.fish_stats.speed_multiplier)])
