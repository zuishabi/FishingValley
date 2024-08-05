class_name SkillManager
extends Node

func load_skill(fish_intent:Intent):
	if(fish_intent.skill_node!=""):
		var skill_node=load(fish_intent.skill_node)
		var child_node=skill_node.instantiate()
		self.add_child(child_node)

func get_fish()->FishArea:
	return $"../Fish"
