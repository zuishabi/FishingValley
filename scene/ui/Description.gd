extends PanelContainer

@onready var object_texture = $VBoxContainer/MarginContainer/ObjectTexture
@onready var object_name = $VBoxContainer/ObjectName
@onready var object_description = $VBoxContainer/ObjectDescription
@onready var using_description = $VBoxContainer/UsingDescription
@onready var information_container = $VBoxContainer/InformationContainer

var information_unit=preload("res://scene/ui/information_unit.tscn")
var null_texture:Texture2D=preload("res://arts/gui/null.png")

func _ready():
	#当物品的聚焦位置改变时更新描述
	self.hide()
	Inventory.focus_changed.connect(update_description)

func update_description():
	for i in information_container.get_children():
		i.queue_free()
	if(Inventory.inventory[Inventory.focused_index]!=null):
		self.show()
		object_texture.texture=Inventory.inventory[Inventory.focused_index].object_texture
		object_name.text="[center]"+Inventory.inventory[Inventory.focused_index].object_name
		object_description.text=Inventory.inventory[Inventory.focused_index].object_description
		update_information()
		if(Inventory.inventory[Inventory.focused_index] is Tool):
			using_description.show()
			using_description.text="[center]"+Inventory.inventory[Inventory.focused_index].using_description
		else:
			using_description.hide()
	else:
		self.hide()

func create_information_unit(description:String,texture:Texture2D):
	var new_information=information_unit.instantiate()
	new_information.update_information(texture,description)
	information_container.add_child(new_information)

func update_information():
	if(Inventory.inventory[Inventory.focused_index] is BiatBag):
		if(Inventory.inventory[Inventory.focused_index].current_biat==null):
			create_information_unit("当前鱼饵",null_texture)
		else:
			create_information_unit("当前鱼饵",Inventory.inventory[Inventory.focused_index].current_biat.object_texture)
