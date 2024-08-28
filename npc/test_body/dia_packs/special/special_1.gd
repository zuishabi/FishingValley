class_name Special_1
extends DiaPack

func can_exist() -> bool:
	if MissionSystem.special_list[self.dia_name] == false:
		return true
	else:
		return false

func end_process(id:int):
	if id == 4:
		MissionSystem.special_list[self.dia_name] = true
