class_name BagSlot
extends PanelContainer

signal show_description
signal hide_description
signal on_selected

@onready var texture_rect = $TextureRect
@onready var label = $MarginContainer/Label

var id:int

func update_slot(item:Item):
	if(item!=null):
		texture_rect.texture=item.object_texture
		label.text=str(item.amount)
	else:
		texture_rect.texture=null
		label.text=""

func _on_mouse_entered():
	show_description.emit(id)

func _on_mouse_exited():
	hide_description.emit()

func _on_gui_input(event:InputEvent):
	if(event.is_action_pressed("left_mouse")):
		on_selected.emit(id)
