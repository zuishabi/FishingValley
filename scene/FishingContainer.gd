extends Node2D

signal end_once_move

@onready var fish = $Fish
@onready var progress_bar = $UI/ProgressBar
@onready var animation_player = $AnimationPlayer
@onready var battle = $".."
@onready var rigid_body_2d = $RigidBody2D
@onready var endurance_bar = $UI/EnduranceBar

var flag:bool=false
var is_moving:bool=false
var current_intent:Intent
var target_speed:int
var length:float

func _ready():
	current_intent=BattleManager.current_fish.intent
	current_intent.update_length.connect(func(len:float):length=len)
	current_intent.update_speed.connect(func(speed:float):target_speed=speed)
	current_intent.skill_used.connect(show_skill)
	current_intent.skill_end.connect(hide_skill)
	progress_bar.max_value=current_intent.max_hp
	reload()

func reload():
	endurance_bar.max_value=BattleManager.player_stats.max_endurance
	endurance_bar.value=endurance_bar.max_value
	progress_bar.value=0
	BattleManager.size=rigid_body_2d.size

func _process(delta):
	if(!is_moving):
		current_intent.update_intent()
		is_moving=true
	if(length>0):
		fish.move(target_speed*delta)
		length-=abs(target_speed)*delta
	else:
		is_moving=false
	current_intent.current_hp=progress_bar.value
	BattleManager.update_position(rigid_body_2d.global_position.y)

func _physics_process(delta):
	flag=false
	for i in fish.get_overlapping_bodies():
		if i is RigidBody2D:
			progress_bar.value+=0.1
			flag=true
			break
	if(!flag):
		progress_bar.value-=0.2
	if(progress_bar.value==progress_bar.max_value):
		BattleManager.on_battle_win()

func show_skill(skill_name:String):
	animation_player.play(skill_name)

func hide_skill():
	animation_player.play("RESET")

func update_endurance(value:float):
	endurance_bar.value-=value
	if(endurance_bar.value==0):
		BattleManager.on_battle_lose()
