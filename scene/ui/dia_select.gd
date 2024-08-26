extends Button

var current_dia_unit:DiaUnit

signal selected(dia_unit:DiaUnit)

func update(dia_unit:DiaUnit):
	current_dia_unit = dia_unit
	self.text = current_dia_unit.content

func _on_pressed():
	selected.emit(current_dia_unit)
