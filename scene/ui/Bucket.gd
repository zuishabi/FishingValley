extends Control

@onready var grid_container = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/GridContainer
@onready var label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var texture_rect = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/ToolTexture/TextureRect
@onready var Ui = $".."
@onready var hover = $Hover
@onready var select = $Select
@onready var bag_description = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/BagDescription
@onready var select_menu = $SelectMenu
@onready var change = $Change
@onready var equiped = $Equiped

var current_container:BaseContainer
var selected:bool=false
var selected_id:int
var can_esc:bool=true

func _input(event):
	if((Ui.focus_array.front()=="Inventory"||Ui.focus_array.front()=="ContainerInventory")&&Inventory.inventory[Inventory.focused_index] is BaseContainer):
		if(event.is_action_pressed("e")):
			Ui.update_ui("ContainerInventory")

func _ready():
	self.hide()
	select.hide()
	hover.hide()
	equiped.hide()
	bag_description.hide()
	var id:int=0
	for i:BagSlot in grid_container.get_children():
		i.id=id
		i.show_description.connect(show_description)
		i.hide_description.connect(hide_description)
		i.on_selected.connect(_on_selected)
		id+=1

func show_ui():
	self.show()
	get_tree().paused=true
	update_ui(Inventory.inventory[Inventory.focused_index])

func hide_ui():
	self.hide()

func update_ui(container:BaseContainer):
	hover.hide()
	equiped.hide()
	disselect()
	bag_description.hide()
	current_container=container
	label.text=container.object_name
	texture_rect.texture=container.object_texture
	#如果是鱼饵袋，就更新当前装备信息
	if(container is BiatBag):
		update_equiped()
	for i in grid_container.get_children():
		i.hide()
	for i in container.max_size:
		grid_container.get_child(i).update_slot(current_container.inventory[i])
		grid_container.get_child(i).show()

func show_description(id:int):
	hover.global_position=grid_container.get_child(id).global_position
	hover.show()
	if(!selected&&current_container.inventory[id]!=null):
		change.stop()
		bag_description.show()
		bag_description.update_description(current_container.inventory[id])

func hide_description():
	hover.hide()
	if(!selected):
		change.start()

func _on_selected(id:int):
	if(current_container.inventory[id]!=null):
		selected=true
		selected_id=id
		select.global_position=grid_container.get_child(id).global_position
		bag_description.update_description(current_container.inventory[id])
		select.show()
		select_menu.update_menu(id,current_container)
		select_menu.global_position=get_global_mouse_position()
		select_menu.show()

func disselect():
	select_menu.hide()
	select.hide()
	selected=false
	selected_id=-1
	bag_description.hide()

func _on_change_timeout():
	bag_description.hide()

func update_equiped():
	if current_container.current_biat==null:
		equiped.hide()
	else:
		equiped.global_position=grid_container.get_child(current_container.current_biat_id).global_position
		equiped.show()
