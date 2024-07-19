extends RigidBody2D

var force:int=20
var size:int

func _input(event):
	if(event.is_action_released("left_mouse")):
		force=20

func _physics_process(delta):
	if(Input.is_action_pressed("left_mouse")):
		var upward_force = Vector2(0, -1)  # 向上的力，根据需要调整力的大小
		apply_central_impulse(upward_force*force)
		force=clampi(force+0.5,20,25)
		get_parent().update_endurance(0.1)
