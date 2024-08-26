extends Control

var can_esc:bool = true
var start_menu:PackedScene = preload("res://scene/ui/start_menu.tscn")

func show_ui():
	self.show()
	get_tree().paused = true

func hide_ui():
	self.hide()

func _on_back_pressed():
	get_parent().update_ui("InsideMenu")

func _on_settings_pressed():
	pass # Replace with function body.

func _on_save_pressed():
	Saver.save_game()
	Saver.current_archiving_information = null
	
	get_tree().paused = false
	get_tree().change_scene_to_packed(start_menu)
