class_name Archiving
extends Resource

@export var player_position:Vector2
@export var face_direction:Vector2
@export var inventory:Array[BaseObject]
@export var npc_list:Array[NPCStats]
@export var mission_list:Dictionary #任务列表
@export var special_list:Dictionary #特殊事件列表

func _init():
	inventory.resize(7)
	player_position = Vector2(1482,318)

func get_npc_stats(npc_name:String) -> NPCStats:
	for i in npc_list:
		if i.npc_name == npc_name:
			return i
	return null
