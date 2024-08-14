extends RigidBody2D

var force:float
var max_force:float
var size:int

func update_pole(player_stats:PlayerStats):
	max_force = player_stats.current_force

func _input(event):
	if(event.is_action_released("left_mouse")):
		force=max_force - 5

func _physics_process(delta):
	if(Input.is_action_pressed("left_mouse")):
		var upward_force = Vector2(0, -1)  # 向上的力，根据需要调整力的大小
		apply_central_impulse(upward_force*force)
		force=clampf(force+0.5,12,max_force)
		get_parent().update_endurance(0.1) # 更新耐力值
