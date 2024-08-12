extends PanelContainer

@onready var buff_name = $VBoxContainer/BuffName
@onready var description = $VBoxContainer/Description

func update_description(buff:Buff):
	buff_name.text = buff.name
	description.text = "[center]" + buff.description
