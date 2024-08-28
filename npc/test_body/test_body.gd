class_name NPC
extends CharacterBody2D

@onready var dia_component = $DiaComponent
@onready var can_talk_texture = $Ui/CanTalk
@export var npc_stats:NPCStats

func _ready():
	Saver.load_request.connect(load_game)
	Saver.save_request.connect(process_saved_request)
	
func get_dia():
	get_node("DiaComponent").get_dia()

func show_talk():
	can_talk_texture.show()

func hide_talk():
	can_talk_texture.hide()

func load_game(saved_game:Archiving):
	if saved_game.get_npc_stats(npc_stats.npc_name) != null: 
		npc_stats = saved_game.get_npc_stats(npc_stats.npc_name)
	else:
		#当存档中没有此npc的数据，可能是第一次创建游戏或者更新了新npc
		init_dia_list() #初始化对话列表

func process_saved_request():
	Saver.get_npc_data(npc_stats)

func init_dia_list():
	for i:DiaPack in dia_component.mission_dia:
		MissionSystem.mission_list[i.dia_name] = false
	for i:DiaPack in dia_component.special_dia:
		MissionSystem.special_list[i.dia_name] = false
