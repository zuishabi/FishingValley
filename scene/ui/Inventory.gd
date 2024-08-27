extends Control

@onready var high_light = $HighLight
@onready var inventory_slots = $Inventory/InventorySlots
var can_esc:bool=false

func show_ui():
	self.show()
	get_tree().paused=false

func _ready():
	Saver.load_request.connect(load_game)
	Inventory.inventory_changed.connect(update_slot)
	Inventory.focus_changed.connect(update_highlight)
	for i in inventory_slots.get_children().size():
		update_slot(i)

func _input(event:InputEvent):
	if(get_parent().focus_array.front()=="Inventory"):
		var direction=int(event.is_action_pressed("wheel_down"))-int(event.is_action_pressed("wheel_up"))
		if(direction!=0):
			Inventory.change_index(direction)

func update_highlight():
	high_light.global_position=inventory_slots.get_child(Inventory.focused_index).global_position

func update_slot(index:int):
	inventory_slots.get_child(index).update_slot(index)

func load_game(saved_game:Archiving):
	for i in inventory_slots.get_children().size():
		update_slot(i)
