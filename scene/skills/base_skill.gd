class_name Skill
extends Resource

enum SKILLTYPE {MAIN,PASSIVE}

@export var use_time:int
@export_file var skill_scene:String
@export var skill_name:String
@export_multiline var skill_description:String
@export var type:SKILLTYPE
@export var skill_texture:Texture2D
