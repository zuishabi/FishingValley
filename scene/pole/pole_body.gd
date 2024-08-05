extends RigidBody2D

var force:float=12
var size:int

func update_pole():
	pass

func _input(event):
	if(event.is_action_released("left_mouse")):
		force=12

func _physics_process(delta):
	if(Input.is_action_pressed("left_mouse")):
		var upward_force = Vector2(0, -1)  # 向上的力，根据需要调整力的大小
		apply_central_impulse(upward_force*force)
		force=clampf(force+0.5,12,17)
		get_parent().update_endurance(0.1) # 更新耐力值
