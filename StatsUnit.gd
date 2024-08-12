extends HBoxContainer

signal mouse_enter
signal mouse_exit

@onready var texture_rect = $TextureRect
@onready var base_label = $BaseLabel
@onready var extra_label = $ExtraLabel

var id:int

@export_multiline var description:String
@export var texture:Texture2D

func update_info(base_value:float,current_value:float=0):
	texture_rect.texture = texture
	base_label.text = str(base_value)
	if (current_value > base_value):
		extra_label.text = "+"+str(current_value-base_value)
	else:
		extra_label.text = ""

func _on_texture_rect_mouse_entered():
	mouse_enter.emit(id)

func _on_texture_rect_mouse_exited():
	mouse_exit.emit(id)
