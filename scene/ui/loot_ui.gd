extends HBoxContainer

signal show_highlight
signal hide_highlight
signal get_item_request

@onready var texture_rect = $MarginContainer/TextureRect
@onready var label = $Label
@onready var label_2 = $Label2

var id:int

func update_loot(loot:Item):
	texture_rect.texture=loot.object_texture
	label.text=loot.object_name
	label_2.text="x"+str(loot.amount)

func _on_mouse_entered():
	show_highlight.emit(id)

func _on_mouse_exited():
	hide_highlight.emit()

func _on_gui_input(event:InputEvent):
	if event.is_action_pressed("left_mouse"):
		get_item_request.emit(id)

