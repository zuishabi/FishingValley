class_name Stats
extends Resource

signal attack(value:int)
signal heal(value:int)
signal health_changed(value:int)

@export var max_health:int
@export var base_armor:int
@export var base_attack:int

var health:int:
	set(value):
		health_changed.emit(value)
		health=value
var current_armor:int
var current_attack:int
var buff_array:Array[Buff]

func reload():
	for i:Buff in buff_array:
		i.use_time-=1
		if(i.use_time == 0):
			buff_array.erase(i)
	current_armor=base_armor
	current_attack=base_attack

func process_effect(object:Stats,value:Effect):
	for i:Buff in buff_array:
		i.apply_effect(object,value)
	if value.effect_type==Effect.TYPE.ATTACK:
		health -= value.effect_value
		attack.emit(value.effect_value)
	elif(value.effect_type==Effect.TYPE.HEAL):
		health += value.effect_value
		heal.emit(value.effect_value)
