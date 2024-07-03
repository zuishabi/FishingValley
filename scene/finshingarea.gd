extends Area2D

@onready var player = $"../../Player"

func _on_body_entered(body):
	Ui.update_ui("Tips",player.global_position)

func _on_body_exited(body):
	Ui.update_ui("Tips")
