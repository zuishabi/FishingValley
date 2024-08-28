class_name Mission_1
extends DiaPack

func can_exist() -> bool:
	if MissionSystem.special_list["special_1"] == true:
		return true
	return false


func end_process(id:int):
	if id == 4:
		MissionSystem.mission_list[self.dia_name] = true
