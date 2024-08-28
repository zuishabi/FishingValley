extends Node

signal save_request
signal load_request(archiving:Archiving)

var player_data:PlayerData
var npc_stats_list:Array[NPCStats]
var saved_settings:SavedSettings
var current_archiving_information:ArchivingInformation

func _ready():
	if ResourceLoader.exists("user://saved_settings.tres"):
		saved_settings = ResourceLoader.load("user://saved_settings.tres")
		EventBus.emit_test(["成功加载设置文件"])
	else:
		EventBus.emit_test(["创建设置文件"])
		var new_settings:SavedSettings = SavedSettings.new()
		saved_settings = new_settings
	if saved_settings.last_version != Utils.version:
		EventBus.emit_test(["版本更新，更新设置文件"])
		override_settings()
		ResourceSaver.save(saved_settings,"user://saved_settings.tres")

func save_game():
	update_archiving_information()
	save_request.emit()
	var saved_game:Archiving = Archiving.new()
	save_global(saved_game)#保存全局数据
	save_player_data(saved_game)#保存玩家数据
	save_npc_data(saved_game)#保存npc数据
	ResourceSaver.save(saved_game,"user://archiving_" + current_archiving_information.archiving_name + ".tres")
	EventBus.emit_test(["保存存档：",current_archiving_information.archiving_name])
	save_settings()

func save_settings():
	EventBus.emit_test(["保存设置文件"])
	ResourceSaver.save(saved_settings,"user://saved_settings.tres")

func load_game():
	if ResourceLoader.exists("user://archiving_" + current_archiving_information.archiving_name + ".tres"):
		var saved_game:Archiving = ResourceLoader.load("user://archiving_" + current_archiving_information.archiving_name + ".tres")
		load_request.emit(saved_game)
		emit_necessary_signal()
	else:
		var saved_game:Archiving = Archiving.new()
		ResourceSaver.save(saved_game,"user://archiving_" + current_archiving_information.archiving_name + ".tres")
		save_settings()
		load_request.emit(saved_game)

func override_settings():
	saved_settings.last_version = Utils.version

#当保存游戏时调用，更新存档信息
func update_archiving_information():
	current_archiving_information.play_time = Time.get_datetime_string_from_system()

#加载完毕后发送一些必要的信号
func emit_necessary_signal():
	pass

#----------------------------------------获取特定数据-------------------------------------------------
#获取玩家数据
func get_player_data(player_data:PlayerData):
	self.player_data = player_data

#获取npc数据
func get_npc_data(npc_stats:NPCStats):
	self.npc_stats_list.append(npc_stats)

#----------------------------------------保存特定数据-------------------------------------------------
func save_global(saved_game:Archiving):
	saved_game.mission_list = MissionSystem.mission_list
	saved_game.special_list = MissionSystem.special_list

func save_player_data(saved_game:Archiving):
	saved_game.player_position = player_data.player_position
	saved_game.face_direction = player_data.face_direction
	saved_game.inventory = Inventory.inventory

func save_npc_data(saved_game:Archiving):
	saved_game.npc_list = npc_stats_list
