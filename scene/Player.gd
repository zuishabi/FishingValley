class_name Player
extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var progress_bar =$Ui/ProgressBar
@onready var line_2d = $Line2D
@onready var hook: Sprite2D = $hook

@export var speed:int=200
@export var face_direction:Vector2
@export var fishing_point:Vector2
@export var player_stats:PlayerStats

var direction:Vector2
var can_move:bool=true
var is_moving:bool=false
var is_fishing:bool=false
var preparing:bool=false
var adding:bool=true
#是否可以钓鱼
var can_fish:bool=true
#是否可以钓上鱼
var can_catch:bool=false

signal fishing_request(pos:Vector2)
signal cancel_fishing
signal catch_fish

func _ready():
	Saver.save_request.connect(process_save_request)
	Saver.load_request.connect(load_game)
	EventBus.leave_fishing.connect(leave_fishing)
	leave_fishing()
	progress_bar.hide()

func _physics_process(delta):
	if(can_move):
		move()

func _input(event):
	if(event.is_action_pressed("left_mouse") && is_fishing):
		if(can_catch):
			catch_fish.emit()
		else:
			leave_fishing()
	if(event.is_action_released("left_mouse") && preparing):
		animation_tree["parameters/fishing/blend_position"]=face_direction
		is_fishing=true
		line_2d.clear_points()
		var target_pos:Vector2=global_position+face_direction*progress_bar.value*1.5
		fishing_request.emit(target_pos)
		fishing_point=face_direction*progress_bar.value*1.5
		var timer=get_tree().create_timer(0.6)
		await timer.timeout
		progress_bar.hide()
		can_move=true
		progress_bar.value=0

func _process(delta):
	if(Input.is_action_pressed("left_mouse") && can_fish && Inventory.inventory[Inventory.focused_index] is FishingPole):
		animation_tree["parameters/prepare/blend_position"]=face_direction
		progress_bar.show()
		preparing=true
		can_move=false
		if(adding):
			progress_bar.value+=0.5
			if(progress_bar.value==100):
				adding=false
		else:
			progress_bar.value-=0.5
			if(progress_bar.value==0):
				adding=true

func move():
	direction=Input.get_vector("left","right","up","down")
	velocity=direction*speed
	if direction!=Vector2.ZERO:
		if(is_fishing):
			leave_fishing()
		is_moving=true
		animation_tree["parameters/idle/blend_position"]=direction
		animation_tree["parameters/run/blend_position"]=direction
		move_and_slide()
	else:
		is_moving=false

func leave_fishing():
	is_fishing = false
	preparing = false
	can_fish = false
	cancel_fishing.emit()
	line_2d.clear_points()
	var timer=get_tree().create_timer(0.3)
	await timer.timeout
	can_fish = true
	can_catch = false

func add_line():
	line_2d.add_point(Vector2(18,-45))
	line_2d.add_point(fishing_point)

func process_save_request():
	var new_data = PlayerData.new()
	new_data.face_direction = face_direction
	new_data.player_position = self.global_position
	Saver.get_player_data(new_data)

func load_game(saved_game:Archiving):
	self.global_position = saved_game.player_position
	self.face_direction = saved_game.face_direction
	animation_tree["parameters/idle/blend_position"] = face_direction
