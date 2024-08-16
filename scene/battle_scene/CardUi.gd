extends CanvasLayer

@onready var next_round: Button = $NextRound
@onready var fish_turn: Button = $FishTurn
@onready var filter: Control = $Filter

func _ready() -> void:
	next_round.hide()
	fish_turn.hide()
	BattleManager.fish_trun_start.connect(func():fish_turn.hide();filter.mouse_filter = 0)
	BattleManager.fish_trun_end.connect(func():next_round.show())
