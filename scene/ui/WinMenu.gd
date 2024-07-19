extends Control

var can_esc:bool=false
var loot_ui=preload("res://scene/ui/loot_ui.tscn")
var fish_item:FishItem

@onready var texture_rect = $PanelContainer/Information/Main/Texture/MarginContainer/TextureRect
@onready var weight = $PanelContainer/Information/Main/Weight/Label2
@onready var value = $PanelContainer/Information/Main/Value/Label2
@onready var time = $PanelContainer/Information/Main/Time/Label2
@onready var ui = $".."
@onready var loots = $PanelContainer/Loots
@onready var information = $PanelContainer/Information
@onready var loot_list = $PanelContainer/Loots/VBoxContainer
@onready var highlight = $Highlight
@onready var close = $Button

func _ready():
	BattleManager.battle_win.connect(on_battle_win)

func on_battle_win(fish:FishItem):
	fish_item=fish
	ui.update_ui("WinMenu")

func show_ui():
	get_tree().paused=true
	update_information()
	information.show()
	loots.hide()
	close.hide()
	self.show()

func hide_ui():
	self.hide()

func update_information():
	texture_rect.texture=fish_item.object_texture
	weight.text=str(fish_item.weight)
	value.text=str(fish_item.value)
	var all_time=BattleManager.end_time-BattleManager.start_time
	var sec:int=all_time/1000
	var minute=sec/60
	sec=sec%60
	time.text=str(minute)+" 分 "+str(sec)+" 秒 "

func _on_right_pressed():
	information.hide()
	loots.show()
	can_esc=true
	close.show()
	for i in BattleManager.final_loots.size():
		var new_loot=loot_ui.instantiate()
		loot_list.add_child(new_loot)
		new_loot.update_loot(BattleManager.final_loots[i])
		new_loot.id=i
		new_loot.show_highlight.connect(show_highlight)
		new_loot.hide_highlight.connect(hide_highlight)
		new_loot.get_item_request.connect(process_get_item_request)

func show_highlight(id:int):
	highlight.global_position=loot_list.get_child(id+1).global_position
	highlight.show()

func hide_highlight():
	highlight.hide()

func process_get_item_request(id:int):
	Inventory.add_item(BattleManager.final_loots[id],BattleManager.final_loots[id].amount)
	loot_list.get_child(id+1).queue_free()
	for i in loot_list.get_children().size():
		if i > id :
			loot_list.get_child(i).id-=1

func _on_button_pressed():
	ui.update_ui("WinMenu")
