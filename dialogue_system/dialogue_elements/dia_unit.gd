class_name DiaUnit
extends Resource

enum TYPE {SELECT,SUBMIT,GET,NORMAL}

@export_multiline var content:String
@export var dia_type:TYPE
@export var dia_texture:Texture2D
@export var next_type:TYPE
@export var next_id:int
@export var id:int
@export var true_id:int
@export var false_id:int
@export var items:Dictionary
