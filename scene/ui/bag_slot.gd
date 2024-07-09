class_name BagSlot
extends PanelContainer

signal show_description
signal hide_description

@onready var texture_rect = $TextureRect

var id:int

func update_slot(item:Item):
	if(item!=null):
		texture_rect.texture=item.object_texture

func _on_mouse_entered():
	show_description.emit(id)

func _on_mouse_exited():
	hide_description.emit()
