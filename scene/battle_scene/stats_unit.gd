extends HBoxContainer

signal mouse_enter
signal mouse_exit

@onready var texture_rect = $TextureRect
@onready var base_label = $BaseLabel
@onready var extra_label = $ExtraLabel

var id:int

@export_multiline var description:String
@export var texture:Texture2D

func _ready() -> void:
	extra_label.label_settings = extra_label.label_settings.duplicate()

func update_info(base_value:float,current_value:float=-1):
	texture_rect.texture = texture
	base_label.text = str(base_value)
	if (current_value > base_value):
		extra_label.label_settings.font_color = Color.GREEN
		extra_label.text = "+"+str(current_value-base_value)
	elif (current_value != -1 && current_value < base_value):
		extra_label.label_settings.font_color = Color.RED
		extra_label.text = "-"+str(base_value-current_value)
	else:
		extra_label.text = ""
	EventBus.emit_test(["当前id",str(id),"当前颜色",str(extra_label.label_settings.font_color)])

func _on_texture_rect_mouse_entered():
	mouse_enter.emit(id)

func _on_texture_rect_mouse_exited():
	mouse_exit.emit(id)
