extends CanvasLayer

@onready var fish_texure = $Main/Fish/FishTexure

func _ready():
	fish_texure.texture=BattleManager.current_fish.fish_texture
	
