extends Node

var player_stats:PlayerStats
var fish_stats:FishStats
var can_use:bool = true

@onready var fish = $"../../Fish"
@onready var sprite_2d_2 = $Sprite2D2
@onready var timer = $Timer

func _ready():
	sprite_2d_2.hide()

func _process(delta):
	if (fish_stats.current_progress / fish_stats.current_max_strength) > 0.5:
		if can_use:
			sprite_2d_2.show()
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_CIRC)
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(sprite_2d_2,"scale",Vector2(5,5),0.5).from(Vector2(0,0))
			sprite_2d_2.global_position = fish.global_position
			timer.start()
			can_use = false

func _on_timer_timeout():
	can_use = true
