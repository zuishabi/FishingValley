extends PanelContainer

@onready var label = $Label

func _ready():
	self.hide()

func update_description(description:String):
	self.show()
	label.text = description
