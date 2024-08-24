extends Control

var load_unit = preload("res://scene/ui/load_unit.tscn")

func _ready():
	for i in Saver.saved_settings.archiving_lists:
		var new_unit = load_unit.instantiate()
		$PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(new_unit)
		new_unit.update(i)
		new_unit.load_game.connect(on_game_load)
		new_unit.delete_game.connect(on_game_delete)

func on_game_load(archiving:ArchivingInformation):
	Saver.current_archiving_information = archiving
	get_tree().change_scene_to_file("res://scene/main.tscn")

func on_game_delete(archiving:ArchivingInformation):
	DirAccess.remove_absolute("user://archiving_" + archiving.archiving_name + ".tres")
	Saver.saved_settings.archiving_lists.erase(archiving)
	Saver.save_settings()
