extends PanelContainer

@onready var skill_name: Label = $VBoxContainer/SkillName
@onready var description: RichTextLabel = $VBoxContainer/Description

func update_description(skill:Skill):
	skill_name.text = skill.skill_name
	description.text = "[center]" + skill.skill_description
