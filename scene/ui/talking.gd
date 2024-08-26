extends Control

var current_dia_pack:DiaPack
var current_dia_unit:DiaUnit
var select_dia_units:Array[DiaUnit]
var tween:Tween
var select_button = preload("res://scene/ui/dia_select.tscn")

@onready var texture_rect = $PanelContainer/HBoxContainer/MarginContainer/TextureRect
@onready var rich_text_label = $PanelContainer/HBoxContainer/PanelContainer/VBoxContainer/RichTextLabel
@onready var select_container = $PanelContainer/HBoxContainer/PanelContainer/VBoxContainer/SelectContainer

func show_ui():
	self.show()
	$"../Inventory".hide()
	get_tree().paused = true

func hide_ui():
	self.hide()

func _ready():
	EventBus.dia_request.connect(process_dia_request)

func process_dia_request(dia_pack:DiaPack):
	current_dia_pack = dia_pack
	get_parent().update_ui("Talking")
	current_dia_unit = current_dia_pack.contents[0]
	parse_current_dia_unit()

func get_next_dia():
	clean()
	if current_dia_unit.next_type == DiaUnit.TYPE.NORMAL:
		current_dia_unit = find_dia_unit(current_dia_unit.next_id)
		parse_current_dia_unit()
	elif current_dia_unit.next_type == DiaUnit.TYPE.SELECT:
		select_dia_units = find_select_dia_units(current_dia_unit.next_id)
		parse_select_dia_unit()

func find_dia_unit(id:int) -> DiaUnit:
	for i in current_dia_pack.contents:
		if i.id == id:
			return i
	return null

func find_select_dia_units(id:int) -> Array[DiaUnit]:
	var array:Array[DiaUnit] = []
	for i in current_dia_pack.contents:
		if i.id == id:
			array.append(i)
	return array

func parse_current_dia_unit():
	rich_text_label.visible_characters = 0
	rich_text_label.text = current_dia_unit.content
	texture_rect.texture = current_dia_unit.dia_texture
	tween = create_tween()
	tween.tween_property(rich_text_label,"visible_characters",current_dia_unit.content.length(),current_dia_unit.content.length()*0.05)

func parse_select_dia_unit():
	for i in select_dia_units:
		var new_select = select_button.instantiate()
		select_container.add_child(new_select)
		new_select.update(i)
		new_select.selected.connect(on_selected)

func on_selected(dia_unit:DiaUnit):
	current_dia_unit = dia_unit
	get_next_dia()

func end_talking():
	get_parent().update_ui("Talking")

func _on_h_box_container_gui_inpust(event:InputEvent):
	if event.is_action_released("left_mouse"):
		if tween && tween.is_running():
			tween.kill()
			rich_text_label.visible_characters = -1
		elif current_dia_unit.dia_type == DiaUnit.TYPE.NORMAL:
			if current_dia_unit.next_id == -1:
				end_talking()
			else:
				get_next_dia()

func clean():
	for i in select_container.get_children():
		i.queue_free()
