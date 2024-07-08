extends PanelContainer

@onready var texture_rect = $TextureRect

func update_slot(index:int):
	texture_rect.texture=Inventory.inventory[index].object_texture
