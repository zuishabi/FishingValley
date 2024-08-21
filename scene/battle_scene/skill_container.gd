extends PanelContainer

var current_stats:Stats
var skill_unit = preload("res://scene/battle_scene/skill_unit.tscn")

@onready var skill_grid: GridContainer = $SkillGrid

func _ready() -> void:
	BattleManager.update_skill_ui.connect(update_buff_ui)

func init(stats:Stats):
	current_stats = stats

func update_buff_ui():
	if current_stats is PlayerStats:
		create_new_unit(current_stats.main_skill)
		for i in current_stats.passiva_skills:
			create_new_unit(i)
	elif current_stats is FishStats:
		create_new_unit(BattleManager.current_fish.skill)
		for i in current_stats.extra_skills:
			create_new_unit(i)

func create_new_unit(skill:Skill):
	var new_unit:SkillUnit = skill_unit.instantiate()
	new_unit.update(skill)
	new_unit.mouse_enter.connect(on_mouse_entered)
	new_unit.mouse_exit.connect(on_mouse_exited)
	skill_grid.add_child(new_unit)

func on_mouse_entered(skill_unit:SkillUnit):
	pass

func on_mouse_exited(skill_unit:SkillUnit):
	pass
