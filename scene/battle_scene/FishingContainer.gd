class_name FishingContainer
extends Node2D

@onready var fish = $Fish
@onready var progress_bar = $Ui/ProgressBar
@onready var pole_body = $PoleBody
@onready var endurance_bar = $Ui/EnduranceBar
@onready var player_skill = $PlayerSkill
@onready var fish_skill = $FishSkill

var battle:Battle
var flag:bool=false
var is_moving:bool=false
var current_intent:Intent
var player_stats:PlayerStats
var fish_stats:FishStats
var target_speed:float
var current_speed:float
var target_direction:int
var length:float
var overlapping_list:Array[PoleShape]

func _ready():
	battle=get_parent()
	current_intent=BattleManager.current_fish.intent
	current_intent.update_length.connect(func(len:float):length=len)
	current_intent.update_speed.connect(func(speed:float):target_speed = speed ; current_speed = target_speed)
	current_intent.update_direction.connect(func(direction:int):target_direction=direction)
	
	#----------------------------加载玩家和鱼的统计数据，并处理他们的buff---------------------------------
	player_stats=BattleManager.player_stats
	fish_stats=BattleManager.current_fish.fish_stats
	player_stats.process_buff()
	fish_stats.process_buff()
	pole_body.update_pole(player_stats)#更新鱼竿信息
	
	#--------------------------------更新玩家的统计界面和鱼的统计界面------------------------------------
	BattleManager.update_player_stats_ui.emit()
	BattleManager.update_buff_ui.emit()
	
	#-----------------------------------加载鱼的进度和玩家的最大耐力------------------------------------
	fish_stats.current_progress = 0
	progress_bar.max_value=fish_stats.current_max_strength
	endurance_bar.max_value=player_stats.current_max_endurance
	endurance_bar.value=endurance_bar.max_value
	progress_bar.value=0
	
	#------------------------------------------加载技能----------------------------------------------
	if player_stats.current_skill != null:
		player_skill.load_skill(player_stats.current_skill)
	if BattleManager.current_fish.skill != null:
		fish_skill.load_skill(BattleManager.current_fish.skill)

#处理鱼的移动
func _process(delta):
	if(!is_moving):
		current_intent.update_intent()
		if(fish.global_position.y==484):
			target_direction=-1
		elif(fish.global_position.y==124):
			target_direction=1
		is_moving=true
	if(length>0):
		fish.move(current_speed*target_direction*delta)
		length-=abs(current_speed)*delta
	else:
		is_moving=false

#处理钓竿
func _physics_process(delta):
	flag=false
	if(overlapping_list.size()!=0):
		fish_stats.current_progress = clampf(fish_stats.current_progress + 0.1,0,100)
		overlapping_list[0].process()
		flag=true
	if(!flag):
		fish_stats.current_progress = clampf(fish_stats.current_progress - 0.2,0,100)
	progress_bar.value = fish_stats.current_progress
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
