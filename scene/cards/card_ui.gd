class_name CardUi
extends Control

@onready var cost_label = $CostContainer/CostLabel

signal use_request

enum states {NORMAL,HOVER,CLICKED}

var current_state:states=states.NORMAL
var can_released:bool=false
var local_mouse_position:Vector2
var initial_position:Vector2=Vector2.ZERO
var pivot:Vector2

@export var card:Card

func _ready():
	cost_label.text=str(card.cost)

func _on_panel_mouse_entered():
	if(current_state==states.NORMAL):
		var tween:Tween=create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"scale",Vector2(1.5,1.5),0.1)
		current_state=states.HOVER

func _on_panel_mouse_exited():
	if(current_state==states.HOVER):
		var tween:Tween=create_tween()
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"scale",Vector2(1,1),0.1)
		current_state=states.NORMAL

func _on_panel_gui_input(event:InputEvent):
	if(current_state==states.HOVER && event.is_action_pressed("left_mouse")):
		scale=Vector2(1,1)
		pivot=get_global_mouse_position()-global_position
		initial_position = global_position
		current_state=states.CLICKED
	if(current_state==states.CLICKED && event.is_action_released("left_mouse")):
		if(can_released):
			use_request.emit(self)
		else:
			back_to_hand()

func _input(event):
	if  current_state==states.CLICKED && event is InputEventMouseMotion:
		scale=Vector2(1,1)
		global_position=get_global_mouse_position()-pivot

func _on_area_2d_area_entered(area):
	if(area.name=="PutArea"):
		can_released=true

func _on_area_2d_area_exited(area):
	if(area.name=="PutArea"):
		can_released=false

func back_to_hand():
	current_state=states.HOVER
	global_position=initial_position
