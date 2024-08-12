class_name BuffUnit
extends PanelContainer

signal mouse_enter(buff_unit:BuffUnit)
signal mouse_exit(buff_unit:BuffUnit)

@onready var texture_rect = $TextureRect
@onready var use_time = $UseTime

var current_buff:Buff

func update(buff:Buff):
	current_buff = buff
	texture_rect.texture = current_buff.texture
	use_time.text = str(current_buff.use_time)

func _on_mouse_entered():
	mouse_enter.emit(self)

func _on_mouse_exited():
	mouse_exit.emit(self)
