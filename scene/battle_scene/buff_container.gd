extends PanelContainer

var current_stats:Stats
var buff_unit = preload("res://scene/battle_scene/buff_unit.tscn")

@onready var buff_grid = $BuffGrid
@onready var buff_description = $Control/BuffDescription

func _ready():
	buff_description.hide()
	BattleManager.update_buff_ui.connect(update_buff_ui)

func init(stats:Stats):
	current_stats = stats

func update_buff_ui():
	for i in buff_grid.get_children():
		i.queue_free()
	for i in current_stats.buff_array:
		var new_buff_unit = buff_unit.instantiate()
		buff_grid.add_child(new_buff_unit)
		new_buff_unit.update(i)
		new_buff_unit.mouse_enter.connect(on_mouse_entered)
		new_buff_unit.mouse_exit.connect(on_mouse_exit)

func on_mouse_entered(buff_unit:BuffUnit):
	buff_description.show()
	buff_description.global_position = buff_unit.global_position + Vector2.RIGHT*40
	buff_description.update_description(buff_unit.current_buff)

func on_mouse_exit(buff_unit:BuffUnit):
	buff_description.hide()
