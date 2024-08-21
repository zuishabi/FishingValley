extends Node

var player_stats:PlayerStats
var fish_stats:FishStats
var use_time:int = 2
var trigger_probability:float = 0.6
var can_effect:bool = false

@onready var check = $Check
@onready var use = $Use
@onready var sprite_2d = $Sprite2D
@onready var fishing_container:FishingContainer = $"../.."
@onready var fish = $"../../Fish"

func _ready():
	sprite_2d.hide()
	check.start()

func _on_check_timeout():
	var chance:float = randf_range(0,1)
	if chance > trigger_probability:
		can_effect = true
		check.stop()
		use.start()
		sprite_2d.show()

func _on_use_timeout():
	can_effect = false
	trigger_probability *= 0.5
	fishing_container.is_moving = false
	use_time -= 1
	sprite_2d.hide()
	if use_time > 0:
		check.start()

func effect():
	sprite_2d.global_position = fish.global_position + Vector2.DOWN*18
	fishing_container.target_speed = 400

func _process(delta):
	if can_effect:
		effect()
