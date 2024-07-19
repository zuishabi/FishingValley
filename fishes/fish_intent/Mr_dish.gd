class_name Mr_dish_skill
extends Intent

var can_skill:bool=true

func skill():
	if(current_hp/max_hp>=0.3&&can_skill):
		skill_used.emit("Mr_dish")
		can_skill=false
		start_cd()

func start_cd():
	BattleManager.get_timer(6).connect("timeout",func():can_skill=true)
