extends Control

@onready var name_line = $PanelContainer/MarginContainer/VBoxContainer/Name/NameLine

var pop_info = preload("res://scene/battle_scene/pop_info.tscn")

func refresh():
	name_line.clear()

func _on_create_pressed():
	for i in Saver.saved_settings.archiving_lists:
		if i.archiving_name == name_line.text:
			var new_pop = pop_info.instantiate()
			add_child(new_pop)
			new_pop.pop("已存在同名存档",get_global_mouse_position() + Vector2.UP*10)
			return
	if name_line.text == "":
		var new_pop = pop_info.instantiate()
		add_child(new_pop)
		new_pop.pop("存档名不为空",get_global_mouse_position() + Vector2.UP*10)
		return
	var new_archiving = ArchivingInformation.new()
	new_archiving.archiving_name = name_line.text
	Saver.current_archiving_information = new_archiving
	Saver.saved_settings.archiving_lists.append(new_archiving)
	get_tree().change_scene_to_file("res://scene/main.tscn")
