extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree

@export var speed:int=200
@export var face_direction:Vector2

var can_move:bool=true
var direction:Vector2
var is_moving:bool=false

func _physics_process(delta):
	if(can_move):
		move()

func move():
	direction=Input.get_vector("left","right","up","down")
	velocity=direction*speed
	move_and_slide()
	if direction!=Vector2.ZERO:
		is_moving=true
		animation_tree["parameters/idle/blend_position"]=direction
		animation_tree["parameters/run/blend_position"]=direction
	else:
		is_moving=false
