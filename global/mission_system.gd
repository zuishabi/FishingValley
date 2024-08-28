extends Node

var mission_list:Dictionary
var special_list:Dictionary

func _ready():
	Saver.load_request.connect(load_game)

func load_game(saved_game:Archiving):
	mission_list = saved_game.mission_list
	special_list = saved_game.special_list
