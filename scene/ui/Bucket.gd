extends Control

@onready var grid_container = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/GridContainer
@onready var label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var texture_rect = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/ToolTexture/TextureRect

var current_inventory:Array[Item]

func _input(event):
	if((Ui.focus_array.front()=="Inventory"||Ui.focus_array.front()=="ContainerInventory")&&Inventory.inventory[Inventory.focused_index] is BaseContainer):
		if(event.is_action_pressed("e")):
			Ui.update_ui("ContainerInventory")

func _ready():
	var id:int=0
	for i:BagSlot in grid_container.get_children():
		i.id=id
		i.show_description.connect(show_description)
		i.hide_description.connect(hide_description)
		id+=1

func show_ui():
	self.show()
	get_tree().paused=true
	update_ui(Inventory.inventory[Inventory.focused_index])

func hide_ui():
	self.hide()

func update_ui(container:BaseContainer):
	current_inventory=container.inventory
	label.text=container.object_name
	texture_rect.texture=container.object_texture
	for i in grid_container.get_children():
		i.hide()
	for i in container.max_size:
		grid_container.get_child(i).update_slot(current_inventory[i])
		grid_container.get_child(i).show()

func show_description(id:int):
	pass

func hide_description():
	pass
