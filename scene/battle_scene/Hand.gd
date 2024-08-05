extends HBoxContainer

@onready var tips = $"../Tips"

func _ready():
	for i:CardUi in get_children():
		i.card.emit_tips.connect(tips.show_tips)
