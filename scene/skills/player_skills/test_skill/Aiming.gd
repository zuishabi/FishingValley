extends Node

@onready var area_2d = $Area2D
@onready var texture = $Area2D/Texture
@onready var tips = $Tips

var normal = preload("res://arts/skills/player_skills/aiming/normal.tres")
var can_fire_texture = preload("res://arts/skills/player_skills/aiming/can_fire.tres")
var player_stats:PlayerStats
var fish_stats:FishStats
var pole_in:bool = false
var fish_in:bool = false
var can_fire:bool = false
var in_aiming:bool = false
var tween:Tween = null

func _ready():
	reload()

func _on_area_2d_area_entered(area):
	if area.is_in_group("fish_area"):
		fish_in = true

func _on_area_2d_area_exited(area):
	if area.is_in_group("fish_area"):
		fish_in = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("pole_body"):
		pole_in = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("pole_body"):
		pole_in = false

func _physics_process(delta):
	if pole_in && fish_in:
		can_fire = true
		texture.texture = can_fire_texture
	else:
		can_fire = false
		texture.texture = normal

func _unhandled_input(event):
	if event.is_action_pressed("fire") && can_fire:
		if in_aiming:
			stop_tween()
		else:
			start_aiming()

func start_aiming():
	in_aiming = true
	get_tree().paused = true
	tween = create_tween()
	tween.set_loops()
	tween.tween_property(texture,"scale",Vector2(3,3),0.5).from(Vector2(2,2))
	tween.tween_property(texture,"scale",Vector2(2,2),0.5).from(Vector2(3,3))

func stop_tween():
	if tween:
		tween.kill()
	var timer = get_tree().create_timer(2)
	var damage:int = texture.scale.x * 10
	fish_stats.current_progress += damage
	tips.show()
	tips.text = str(damage) + "!"
	var new_tween = create_tween()
	new_tween.set_parallel()
	new_tween.set_trans(Tween.TRANS_CIRC)
	new_tween.tween_property(tips,"global_position",Vector2(675,297),2).from(area_2d.global_position)
	new_tween.tween_property(tips,"scale",Vector2(0,0),2).from(Vector2(2,2))
	print("受到" + str(damage) + "点伤害")
	print(fish_stats.current_progress)
	await timer.timeout
	get_tree().paused = false
	in_aiming = false
	reload()

func reload():
	var rand_y:int = randi_range(128,480)
	area_2d.global_position = Vector2(568,rand_y)
	texture.scale = Vector2(2,2)
