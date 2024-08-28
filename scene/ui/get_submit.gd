extends Control

signal result(id:int)

@onready var grid_container = $PanelContainer/VBoxContainer/MarginContainer/GridContainer
@onready var _get = $PanelContainer/VBoxContainer/HBoxContainer/Get
@onready var submit = $PanelContainer/VBoxContainer/HBoxContainer/Submit
@onready var cancel = $PanelContainer/VBoxContainer/HBoxContainer/Cancel

var slot = preload("res://scene/ui/bag_slot.tscn")
var item_list:Array[BaseObject]

func update(item_list:Array[BaseObject],type:DiaUnit.TYPE):
	self.item_list = item_list
	for i in grid_container.get_children():
		i.queue_free()
	var id:int = 0
	for i in item_list:
		var new_slot = slot.instantiate()
		grid_container.add_child(new_slot)
		new_slot.id = id
		id += 1
		new_slot.update_slot(i)
	if type == DiaUnit.TYPE.GET:
		_get.show()
		submit.hide()
		cancel.hide()
	elif type == DiaUnit.TYPE.SUBMIT:
		submit.show()
		_get.hide()
	else:
		print("提交领取显示框错误")

func _on_get_pressed():
	for i in item_list:
		if i is Item:
			Inventory.add_item(i,i.amount)
		else:
			Inventory.add_item(i)
	result.emit(3)

func _on_submit_pressed():
	var flag:bool = true
	for i:Item in item_list:
		if ! Inventory.find_item(i,i.amount):
			flag = false
			break
	if flag:
		for i:Item in item_list:
			Inventory.delete_item(i,i.amount)
		result.emit(0)
	else:
		result.emit(1)

func _on_cancel_pressed():
	result.emit(1)
