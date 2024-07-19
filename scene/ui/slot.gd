extends PanelContainer

@onready var texture_rect = $TextureRect

func update_slot(index:int):
	if(Inventory.inventory[index]==null):
		texture_rect.texture=null
	else:
		texture_rect.texture=Inventory.inventory[index].object_texture
