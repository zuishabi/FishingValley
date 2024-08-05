class_name Battle
extends Node2D

#当前回合，如果为1则是钓鱼回合，0为卡牌回合
var current_round:int=0
var fishing_container=preload("res://scene/battle_scene/fishing_container.tscn")
var card_scene=preload("res://scene/battle_scene/card_scene.tscn")

func _ready():
	on_round_changed(0)

func on_round_changed(target_round:int):
	current_round=target_round
	if(target_round==1):
		var current_scene=get_tree().get_first_node_in_group("CardScene")
		if(current_scene != null):
			current_scene.queue_free()
		var new_scene=fishing_container.instantiate()
		add_child(new_scene)
	else:
		var current_scene=get_tree().get_first_node_in_group("FishingContainer")
		if(current_scene != null):
			current_scene.queue_free()
		var new_scene=card_scene.instantiate()
		add_child(new_scene)
