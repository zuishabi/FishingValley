extends Control

var current_dia_pack:DiaPack
var current_dia_unit:DiaUnit
var select_dia_units:Array[DiaUnit]
var tween:Tween
var select_button = preload("res://scene/ui/dia_select.tscn")

@onready var texture_rect = $PanelContainer/HBoxContainer/MarginContainer/TextureRect
@onready var rich_text_label = $PanelContainer/HBoxContainer/PanelContainer/VBoxContainer/RichTextLabel
@onready var select_container = $PanelContainer/HBoxContainer/PanelContainer/VBoxContainer/SelectContainer
@onready var get_submit = $GetSubmit

func show_ui():
	self.show()
	$GetSubmit.hide()
	$"../Inventory".hide()
	get_tree().paused = true

func hide_ui():
	self.hide()

func _ready():
	EventBus.dia_request.connect(process_dia_request)
	get_submit.result.connect(get_result)

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
	elif current_dia_unit.next_type == DiaUnit.TYPE.GET:
		current_dia_unit = find_dia_unit(current_dia_unit.next_id)
		parse_get_dia_unit()
	elif current_dia_unit.next_type == DiaUnit.TYPE.SUBMIT:
		current_dia_unit = find_dia_unit(current_dia_unit.next_id)
		parse_submit_dia_unit()

#解析普通函数
func parse_current_dia_unit():
	rich_text_label.visible_characters = 0
	rich_text_label.text = current_dia_unit.content
	texture_rect.texture = current_dia_unit.dia_texture
	tween = create_tween()
	tween.tween_property(rich_text_label,"visible_characters",current_dia_unit.content.length(),current_dia_unit.content.length()*0.05)

#解析选择函数
func parse_select_dia_unit():
	for i in select_dia_units:
		var new_select = select_button.instantiate()
		select_container.add_child(new_select)
		new_select.update(i)
		new_select.selected.connect(on_selected)

#解析领取物品的函数
func parse_get_dia_unit():
	var item_array:Array[BaseObject]
	for i in current_dia_unit.items.keys():
		var new_item:BaseObject = ObjectList.find_object(i)
		if new_item is Item:
			new_item = ObjectList.get_item(i,current_dia_unit.items[i])
		item_array.append(new_item)
	get_submit.show()
	get_submit.update(item_array,DiaUnit.TYPE.GET)

func parse_submit_dia_unit():
	var item_array:Array[BaseObject]
	for i in current_dia_unit.items.keys():
		var new_item:BaseObject = ObjectList.find_object(i)
		if new_item is Item:
			new_item = ObjectList.get_item(i,current_dia_unit.items[i])
		item_array.append(new_item)
	get_submit.show()
	get_submit.update(item_array,DiaUnit.TYPE.SUBMIT)

#寻找普通的对话体
func find_dia_unit(id:int) -> DiaUnit:
	for i in current_dia_pack.contents:
		if i.id == id:
			return i
	return null

#寻找选择对话体
func find_select_dia_units(id:int) -> Array[DiaUnit]:
	var array:Array[DiaUnit] = []
	for i in current_dia_pack.contents:
		if i.id == id:
			array.append(i)
	return array

func on_selected(dia_unit:DiaUnit):
	current_dia_unit = dia_unit
	get_next_dia()

func get_result(id:int):
	if id == 0:
		current_dia_unit.next_id = current_dia_unit.true_id
	else:
		current_dia_unit.next_id = current_dia_unit.false_id
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
	get_submit.hide()
	for i in select_container.get_children():
		i.queue_free()
