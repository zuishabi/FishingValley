extends PanelContainer

var current_stats:Stats
var skill_unit = preload("res://scene/battle_scene/skill_unit.tscn")

@onready var skill_grid: GridContainer = $SkillGrid
@onready var skill_description = $Control/SkillDescription

func _ready() -> void:
	BattleManager.update_skill_ui.connect(update_skill_ui)
	skill_description.hide()

func init(stats:Stats):
	current_stats = stats

func update_skill_ui():
	for i in skill_grid.get_children():
		i.queue_free()
	if current_stats is PlayerStats:
		if current_stats.main_skill != null:
			create_new_unit(current_stats.main_skill)
		for i in current_stats.passive_skills:
			create_new_unit(i)
	elif current_stats is FishStats:
		if BattleManager.current_fish.skill != null:
			create_new_unit(BattleManager.current_fish.skill)
		for i in current_stats.extra_skills:
			create_new_unit(i)

func create_new_unit(skill:Skill):
	var new_unit:SkillUnit = skill_unit.instantiate()
	skill_grid.add_child(new_unit)
	new_unit.update(skill)
	new_unit.mouse_enter.connect(on_mouse_entered)
	new_unit.mouse_exit.connect(on_mouse_exited)

func on_mouse_entered(skill_unit:SkillUnit):
	skill_description.show()
	skill_description.global_position = skill_unit.global_position + Vector2.RIGHT*40
	skill_description.update_description(skill_unit.current_skill)

func on_mouse_exited(skill_unit:SkillUnit):
	skill_description.hide()
