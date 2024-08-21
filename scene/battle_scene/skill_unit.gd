class_name SkillUnit
extends PanelContainer

@onready var use_time: Label = $UseTime
@onready var texture_rect: TextureRect = $TextureRect

signal mouse_enter(skill_unit:SkillUnit)
signal mouse_exit(skill_unit:SkillUnit)

var current_skill:Skill

func update(skill:Skill):
	current_skill = skill
	use_time.text = str(current_skill.use_time)
	texture_rect.texture = current_skill.skill_texture

func _on_mouse_entered() -> void:
	mouse_enter.emit(self)

func _on_mouse_exited() -> void:
	mouse_exit.emit(self)
