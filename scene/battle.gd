extends CanvasLayer
@onready var fish_texure = $Main/Fish/FishTexure

func _ready():
	fish_texure.texture=EventBus.current_fish.fish_texture
