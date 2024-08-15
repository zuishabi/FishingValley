extends PoleShape

@onready var timer = $Timer

var is_active:bool=false
var fishing_container:FishingContainer

func _ready():
	fishing_container=get_tree().get_first_node_in_group("FishingContainer")
	
func process():
	if is_active :
		fishing_container.current_speed =fishing_container.target_speed*0.5
		timer.start()
	else:
		is_active=true

func _on_timer_timeout():
	is_active=false
	fishing_container.current_speed = fishing_container.target_speed
