extends Control

@onready var player = $Player
@onready var fish = $Fish
@onready var player_texture = $Player/PlayerTexture
@onready var fish_texture = $Fish/FishTexture
@onready var buttons = $Buttons

func _ready():
	self.hide()
	buttons.hide()

func show_ui():
	self.show()
	get_tree().paused=true
	start_prepare()

func hide_ui():
	self.hide()

func start_prepare():
	fish_texture.texture=EventBus.current_fish.fish_texture
	var tween:Tween=create_tween()
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(player,"position",Vector2(56,40),0.5).from(Vector2(-48,40))
	tween.tween_property(fish,"position",Vector2(152,40),0.5).from(Vector2(256,40))
	await tween.finished
	buttons.show()

func _on_confirm_pressed():
	EventBus.start_fisht()
	Ui.update_ui("StartMenu")

func _on_cancel_pressed():
	Ui.update_ui("StartMenu")
