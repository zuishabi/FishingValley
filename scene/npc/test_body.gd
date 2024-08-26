extends CharacterBody2D

@onready var talk_area = $TalkArea

var can_talk:bool = false

func _physics_process(delta):
	for i in talk_area.get_overlapping_bodies():
		if i.is_in_group("player") && has_node("DiaComponent"):
			can_talk = true
		else:
			can_talk = false

func _unhandled_input(event):
	if event.is_action_pressed("e") && can_talk:
		var dia_component:DiaComponent = get_node("DiaComponent")
		dia_component.get_dia()
		print("开始对话")
