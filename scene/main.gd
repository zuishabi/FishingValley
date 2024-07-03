extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player
@onready var mouse_texture = $MouseTexture
@onready var line_2d = $Line2D
@onready var progress_bar = $Player/ProgressBar
@onready var fishing_timer = $FishingTimer
@onready var texture_rect = $TextureRect

var mouse_pos_in_tile:Vector2
var is_fishing:bool=false
var adding:bool=true
var next_fish:Fish
var target_pos:Vector2#钓鱼竿落点的位置

func _process(delta):
	mouse_pos_in_tile=tile_map.local_to_map(get_global_mouse_position())
	if(get_tile_data(mouse_pos_in_tile,0,"can_fishing")):
		mouse_texture.global_position=get_global_mouse_position()
		mouse_texture.show()
	else:
		mouse_texture.hide()
	if(mouse_texture.visible&&Input.is_action_pressed("left_mouse")&&player.is_moving==false):
		player.can_move=false
		progress_bar.show()
		if(adding):
			progress_bar.value+=0.5
			if(progress_bar.value==100):	
				adding=false
		else:
			progress_bar.value-=0.5
			if(progress_bar.value==0):
				adding=true
	if(mouse_texture.visible&&Input.is_action_just_released("left_mouse")):
		is_fishing=true
		player.can_move=true
		line_2d.clear_points()
		var dir:Vector2=(get_global_mouse_position()-player.global_position).normalized()
		target_pos=player.global_position+dir*progress_bar.value*1.5
		var target_tile_pos:Vector2=tile_map.local_to_map(target_pos)
		line_2d.add_point(player.global_position)
		line_2d.add_point(target_pos)
		if(!get_tile_data(target_tile_pos,0,"can_fishing")):
			var timer=get_tree().create_timer(0.5)
			await timer.timeout
			leave()
		progress_bar.hide()
		progress_bar.value=0
		get_next_fish(target_tile_pos)
		update_fishing_timer()
	if(is_fishing&&player.is_moving):
		leave()

func get_tile_data(target_position:Vector2,layer:int,custom_data_layer:String):
	var tile_data:TileData=tile_map.get_cell_tile_data(layer,target_position)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false

func leave():
	line_2d.clear_points()
	is_fishing=false
	fishing_timer.stop()
	texture_rect.hide()

func get_next_fish(pos:Vector2):
	var pool:String=get_tile_data(pos,0,"pool")
	next_fish=FishPicker.get_fish(pool)

func update_fishing_timer():
	var await_time:float=randf_range(5,10)
	fishing_timer.wait_time=await_time
	fishing_timer.start()

func _on_fishing_timer_timeout():
	texture_rect.texture=next_fish.fish_texture
	var tween:Tween=create_tween()
	texture_rect.global_position=target_pos
	texture_rect.show()
	tween.tween_property(texture_rect,"global_position",target_pos+Vector2.UP*20,0.5)
