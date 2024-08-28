class_name DiaComponent
extends Node

@export var mission_dia:Array[DiaPack]
@export var normal_dia:Array[DiaPack]
@export var special_dia:Array[DiaPack]

func get_dia():
	for i in special_dia:
		if MissionSystem.special_list[i.dia_name] == false && i.can_exist():
			EventBus.dia_request.emit(i)
			return
	for i in mission_dia:
		if MissionSystem.mission_list[i.dia_name] == false && i.can_exist():
			EventBus.dia_request.emit(i)
			return
	while(1):
		var rand:int = randi_range(0,normal_dia.size()-1)
		if normal_dia[rand].can_exist():
			EventBus.dia_request.emit(normal_dia[rand])
			return
