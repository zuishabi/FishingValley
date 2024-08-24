extends HBoxContainer

signal load_game(archiving:ArchivingInformation)
signal delete_game(archiving:ArchivingInformation)

var current_archiving:ArchivingInformation

@onready var texture_rect = $TextureRect
@onready var _name = $Name
@onready var time = $Time

func update(archiving_information:ArchivingInformation):
	var new_image:ImageTexture = ImageTexture.create_from_image(archiving_information.game_texture)
	if new_image != null:
		new_image.set_size_override(Vector2(80,80))
		texture_rect.texture = new_image
	_name.text = archiving_information.archiving_name
	time.text = archiving_information.play_time
	current_archiving = archiving_information

func _on_button_pressed():
	load_game.emit(current_archiving)

func _on_delete_pressed():
	delete_game.emit(current_archiving)
	self.queue_free()
