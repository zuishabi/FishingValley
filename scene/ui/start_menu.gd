extends CanvasLayer

@onready var information = $Main/Information
@onready var load_game = $Main/VBoxContainer/LoadGame
@onready var create_game_menu = $CreateGameMenu
@onready var load_game_menu = $LoadGameMenu
@onready var main = $Main

func _ready():
	#更新显示
	main.show()
	create_game_menu.hide()
	load_game_menu.hide()
	update_load_menu()
	information.text = "版本 " + Utils.version

func update_load_menu():
	if Saver.saved_settings.archiving_lists.size() != 0:
		load_game.show()
	else:
		load_game.hide()

func _on_exit_pressed():
	Saver.save_settings()
	get_tree().quit()

func _on_create_game_pressed():
	main.hide()
	create_game_menu.show()

func _on_back_pressed():
	main.show()
	create_game_menu.hide()
	create_game_menu.refresh()

func _on_load_game_pressed():
	main.hide()
	load_game_menu.show()

func _on_load_back_pressed():
	main.show()
	load_game_menu.hide()
	update_load_menu()
