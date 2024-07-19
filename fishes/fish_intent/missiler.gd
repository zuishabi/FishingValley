class_name missiler_skill
extends Intent

var can_skill:float=true
var speed_up:bool=false

func fix():
	if(direction_change_time==0):
		target_speed=200
		length=200

func skill():
	if(current_hp/max_hp>=0.5&&can_skill):
		can_skill=false
		skill_used.emit("missiler")
		end_skill()
	if(speed_up):
		target_speed=350

func end_skill():
	speed_up=true
	BattleManager.get_timer(1).connect("timeout",stop_speed_up)

func stop_speed_up():
	speed_up=false
	skill_end.emit()
