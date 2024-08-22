extends Control

@onready var skill_container = $MainPanel/HBoxContainer/SkillContainer
@onready var buff_container = $MainPanel/HBoxContainer/BuffContainer

var fish_stats:FishStats

func _ready():
	skill_container.hide()
	buff_container.show()
	fish_stats = BattleManager.current_fish.fish_stats
	skill_container.init(fish_stats)
	buff_container.init(fish_stats)

func changed_container(id:int):
	if id == 0:
		buff_container.show()
		skill_container.hide()
	else:
		buff_container.hide()
		skill_container.show()

func _on_buff_pressed():
	changed_container(0)

func _on_skill_pressed():
	changed_container(1)
