extends PanelContainer

@onready var object_texture = $VBoxContainer/MarginContainer/ObjectTexture
@onready var object_name = $VBoxContainer/ObjectName
@onready var object_description = $VBoxContainer/ObjectDescription
@onready var using_description = $VBoxContainer/UsingDescription

func _ready():
	Inventory.focus_changed.connect(update_description)
	self.hide()

func update_description():
	if(Inventory.inventory[Inventory.focused_index]!=null):
		self.show()
		object_texture.texture=Inventory.inventory[Inventory.focused_index].object_texture
		object_name.text="[center]"+Inventory.inventory[Inventory.focused_index].object_name
		object_description.text=Inventory.inventory[Inventory.focused_index].object_description
		if(Inventory.inventory[Inventory.focused_index] is Tool):
			using_description.show()
			using_description.text="[center]"+Inventory.inventory[Inventory.focused_index].using_description
		else:
			using_description.hide()
	else:
		self.hide()
