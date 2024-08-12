class_name FishingContainer
extends Node2D

@onready var fish = $Fish
@onready var progress_bar = $Ui/ProgressBar
@onready var pole_body = $PoleBody
@onready var endurance_bar = $Ui/EnduranceBar

var battle:Battle
var flag:bool=false
var is_moving:bool=false
var current_intent:Intent
var player_stats:PlayerStats
var fish_stats:FishStats
var target_speed:float
var target_direction:int
var length:float
var overlapping_list:Array[PoleShape]

func _ready():
	battle=get_parent()
	current_intent=BattleManager.current_fish.intent
	current_intent.update_length.connect(func(len:float):length=len)
	current_intent.update_speed.connect(func(speed:float):target_speed=speed)
	current_intent.update_direction.connect(func(direction:int):target_direction=direction)
	player_stats=BattleManager.player_stats
	fish_stats=BattleManager.current_fish.fish_stats
	player_stats.process_buff()
	fish_stats.process_buff()
	BattleManager.update_player_stats_ui.emit()
	BattleManager.update_buff_ui.emit()
	progress_bar.max_value=fish_stats.current_max_strength
	endurance_bar.max_value=player_stats.current_max_endurance
	endurance_bar.value=endurance_bar.max_value
	progress_bar.value=0

func _process(delta):
	if(!is_moving):
		current_intent.update_intent()
		if(fish.global_position.y==484):
			target_direction=-1
		elif(fish.global_position.y==124):
			target_direction=1
		is_moving=true
	if(length>0):
		fish.move(target_speed*target_direction*delta)
		length-=abs(target_speed)*delta
	else:
		is_moving=false

func _physics_process(delta):
	flag=false
	if(overlapping_list.size()!=0):
		progress_bar.value+=0.1
		overlapping_list[0].process()
		flag=true
	if(!flag):
		progress_bar.value-=0.2
	if(progress_bar.value==progress_bar.max_value):
		print("progress = 100%")
		battle_account()

func update_endurance(value:float):
	endurance_bar.value-=value
	if(endurance_bar.value==0):
		print("endurance = 0")
		battle_account()

func _on_fish_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	overlapping_list.push_front(pole_body.get_child(body_shape_index+1))

func _on_fish_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	overlapping_list.erase(pole_body.get_child(body_shape_index+1))

func battle_account():
	var stantard_attack:float = fish_stats.current_max_strength/2 - fish_stats.current_armor + player_stats.current_armor
	if fish_stats.current_max_strength-progress_bar.value >= stantard_attack :
		var new_effect = Effect.new(Effect.TYPE.ATTACK,fish_stats.current_attack)
		player_stats.process_effect(new_effect)
		print("player is attacked,health:"+str(player_stats.health))
	else:
		var new_effect = Effect.new(Effect.TYPE.ATTACK,player_stats.current_attack)
		fish_stats.process_effect(new_effect)
		print("fish is attacked,health:"+str(fish_stats.health))
	if player_stats.health == 0 :
		BattleManager.on_battle_lose()
	elif fish_stats.health == 0:
		BattleManager.on_battle_win()
	battle.round_change(0)
