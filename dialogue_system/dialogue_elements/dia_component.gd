class_name DiaComponent
extends Node

@export var mission_dia:Array[DiaPack]
@export var normal_dia:Array[DiaPack]

var current_mission:DiaPack

func get_dia():
	if current_mission != null:
		EventBus.dia_request.emit(current_mission)
	for i in mission_dia:
		if i.can_exist():
			EventBus.dia_request.emit(i)
			return
	while(1):
		var rand:int = randi_range(0,normal_dia.size()-1)
		if normal_dia[rand].can_exist():
			EventBus.dia_request.emit(normal_dia[rand])
			return
