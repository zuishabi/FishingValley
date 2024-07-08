extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player
@onready var mouse_texture = $MouseTexture
@onready var ding = $Ui/Ding
@onready var wait_time = $Timers/WaitTime
@onready var can_catch_time = $Timers/CanCatchTime

var next_fish:Fish#下一条鱼
var fishing_pos:Vector2#鱼竿落点的位置

func _ready():
	player.fishing_request.connect(process_fishing_request)
	player.cancel_fishing.connect(cancel_fishing)
	player.catch_fish.connect(on_fish_caught)

func get_tile_data(target_position:Vector2,layer:int,custom_data_layer:String):
	var tile_data:TileData=tile_map.get_cell_tile_data(layer,target_position)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false

func get_next_fish(pos:Vector2):
	var pool:String=get_tile_data(pos,0,"pool")
	next_fish=FishPicker.get_fish(pool)

func process_fishing_request(target_pos:Vector2):
	fishing_pos=target_pos
	if(get_tile_data(tile_map.local_to_map(target_pos),0,"can_fishing")):
		get_next_fish(tile_map.local_to_map(target_pos))
		var rand_time:float=randf_range(5,10)
		wait_time.wait_time=rand_time
		wait_time.start()
	else:
		var timer=get_tree().create_timer(1.5)
		await timer.timeout
		player.leave_fishing()

func _on_wait_time_timeout():
	catch_fish()

func catch_fish():
	player.can_catch=true
	can_catch_time.start()
	var tween:Tween=create_tween()
	ding.position=fishing_pos
	ding.show()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(ding,"position",fishing_pos+Vector2.UP*10,0.2)

func cancel_fishing():
	wait_time.stop()

func _on_can_catch_time_timeout():
	ding.hide()
	player.can_catch=false
	process_fishing_request(fishing_pos)

func on_fish_caught():
	can_catch_time.stop()
	ding.hide()
	EventBus.load_fight(player.player_stats,next_fish)
	Ui.prepare_fishing.emit()
