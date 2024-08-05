extends Node2D

@onready var battle:Battle = $".."
@onready var hand = $CardUi/Hand
@onready var mana = $CardUi/Mana

var fish_stats:FishStats
var player_stats:PlayerStats
var hand_cards:Array[Card]

func _ready():
	fish_stats=BattleManager.current_fish.fish_stats
	player_stats=BattleManager.player_stats
	player_stats.mana_changed.connect(mana._on_mana_changed)
	player_stats.reload()#重新载入玩家统计信息，例如当前魔力，力量和最大耐力等
	get_cards()
	hand.get_cards()

func process_use_request(card_ui:CardUi):
	var card:Card=card_ui.card
	if card.can_use(player_stats):
		if card.target == card.TARGET.SELF:
			card.effect(player_stats)
		else:
			card.effect(fish_stats)
		card.use_time -= 1
		player_stats.current_mana -= card.cost
		if(card.use_time == 0):
			pass
		else:
			BattleManager.discard_hands.append(card)
		hand_cards.erase(card)
		card_ui.queue_free()
	else:
		card_ui.back_to_hand()

func _on_next_round_pressed():
	battle.on_round_changed(1)
	for i in hand_cards.size():
		BattleManager.discard_hands.append(hand_cards.pop_front())

func get_cards():
	for i in 5:
		if(BattleManager.cards_inventory.size()==0):
			get_discard()
		var new_card=BattleManager.cards_inventory.pop_front()
		if(new_card!=null):
			hand_cards.append(new_card)

func get_discard():
	for i in BattleManager.discard_hands:
		BattleManager.cards_inventory.append(i)
	BattleManager.discard_hands.clear()
	BattleManager.cards_inventory.shuffle()
