class_name FishSkill
extends Node

@onready var fishing_container = $".."

func load_skill(skill:Skill):
	var skill_scene = load(skill.skill_scene).instantiate()
	skill_scene.player_stats = fishing_container.player_stats
	skill_scene.fish_stats = fishing_container.fish_stats
	add_child(skill_scene)
