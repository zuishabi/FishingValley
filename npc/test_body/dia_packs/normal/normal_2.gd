class_name Normal_2
extends DiaPack

func can_exist() -> bool:
	if MissionSystem.mission_list["mission_1"] == true:
		return true
	else:
		return false
