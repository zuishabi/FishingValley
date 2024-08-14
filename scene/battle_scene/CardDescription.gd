extends PanelContainer

@onready var card_name = $VBoxContainer/CardName
@onready var cost_value = $VBoxContainer/HBoxContainer/CostValue
@onready var type_value = $VBoxContainer/HBoxContainer/TypeValue
@onready var card_description = $VBoxContainer/CardDescription

func _ready():
	self.hide()

func show_card_description(card:Card):
	self.show()
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.2).from(Color(1,1,1,0))
	card_name.text = card.object_name
	cost_value.text = str(card.cost)
	type_value.text = get_card_type(card)
	card_description.text = "[center]" + card.object_description

func hide_card_description():
	self.hide()

func get_card_type(card:Card)->String:
	if card.card_type == Card.TYPE.NROAML:
		return "普通牌"
	elif card.card_type == Card.TYPE.SKILL:
		return "技能牌"
	else:
		return "钓竿牌"
