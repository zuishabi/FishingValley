class_name DiaPack
extends Resource

@export var dia_name:String
@export var contents:Array[DiaUnit]

func can_exist() -> bool:
	return true

func start_process():
	pass

func end_process(id:int):
	pass
