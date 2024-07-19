extends Control

var can_esc:bool=true

@onready var ui = $".."
@onready var texture_rect = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/TextureRect
@onready var rich_text_label = $PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
@onready var label_2 = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Label2

func _ready():
	BattleManager.battle_lose.connect(on_battle_lose)

func on_battle_lose():
	ui.update_ui("LoseMenu")

func show_ui():
	get_tree().paused=true
	self.show()
	update_information()

func hide_ui():
	self.hide()

func update_information():
	texture_rect.texture=BattleManager.current_fish.fish_texture
	var all_time=BattleManager.end_time-BattleManager.start_time
	var sec:int=all_time/1000
	var minute=sec/60
	sec=sec%60
	label_2.text=str(minute)+" 分 "+str(sec)+" 秒 "

func _on_button_pressed():
	ui.update_ui("LoseMenu")
