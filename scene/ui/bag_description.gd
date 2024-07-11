extends PanelContainer


func update_description(item:Item):
	$MarginContainer/VBoxContainer/MarginContainer/TextureRect.texture=item.object_texture
	$MarginContainer/VBoxContainer/Label.text=item.object_name
	$MarginContainer/VBoxContainer/RichTextLabel.text=item.object_description
	$MarginContainer/VBoxContainer/HBoxContainer/Value.text=str(item.value)
