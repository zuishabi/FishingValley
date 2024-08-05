extends HBoxContainer

@onready var tips = $"../Tips"
@onready var card_scene = $"../.."
@onready var get_cd = $"../../GetCD"

var card_ui=preload("res://scene/cards/card_ui.tscn")

func get_cards():
	for i in card_scene.hand_cards:
		var new_card_ui:CardUi=card_ui.instantiate()
		new_card_ui.card=i
		new_card_ui.card.emit_tips.connect(tips.show_tips)
		new_card_ui.use_request.connect(card_scene.process_use_request)
		add_child(new_card_ui)
		get_cd.start()
		await get_cd.timeout
