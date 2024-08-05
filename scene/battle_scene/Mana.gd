extends PanelContainer

@onready var label = $Label

func _on_mana_changed(value:int,max_mana:int):
	label.text=str(value)+"/"+str(max_mana)
