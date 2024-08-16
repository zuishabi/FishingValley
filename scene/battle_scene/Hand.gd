extends HBoxContainer

@onready var tips = $"../Tips"
@onready var card_scene = $"../.."
@onready var get_cd = $"../../GetCD"
@onready var filter = $"../Filter"
@onready var card_description = $"../CardDescription"
@onready var fish_turn: Button = $"../FishTurn"

var card_ui=preload("res://scene/cards/card_ui.tscn")

func get_cards():
	filter.mouse_filter=0
	for i in card_scene.hand_cards:
		var new_card_ui:CardUi=card_ui.instantiate()
		new_card_ui.card=i
		new_card_ui.card.emit_tips.connect(tips.show_tips)
		new_card_ui.use_request.connect(card_scene.process_use_request)
		new_card_ui.mouse_enter.connect(card_description.show_card_description)
		new_card_ui.mouse_exit.connect(card_description.hide_card_description)
		add_child(new_card_ui)
		get_cd.start()
		await get_cd.timeout
	filter.mouse_filter=2
	fish_turn.show()
