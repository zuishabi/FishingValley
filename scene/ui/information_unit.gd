extends HBoxContainer

func update_information(texture:Texture2D,description:String):
	$Label.text=description
	$MarginContainer/TextureRect.texture=texture
