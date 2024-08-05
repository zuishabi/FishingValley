extends PoleShape

@onready var timer = $Timer

var pre_speed:float
var is_active:bool=false
var fishing_container:FishingContainer

func _ready():
	fishing_container=get_tree().get_first_node_in_group("FishingContainer")
	
func process():
	if is_active :
		fishing_container.target_speed=pre_speed*0.5
		timer.start()
	else:
		pre_speed=fishing_container.target_speed
		is_active=true

func _on_timer_timeout():
	is_active=false
	fishing_container.target_speed=pre_speed
