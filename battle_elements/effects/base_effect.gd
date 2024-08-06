class_name Effect
extends Resource

enum TYPE {ATTACK,HEAL}

var effect_type:TYPE
var effect_value:int

func _init(type:TYPE,value:int):
	effect_type=type
	effect_value=value
