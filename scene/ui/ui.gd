extends CanvasLayer

signal prepare_fishing

@onready var label = $Label

var focus_array:Array[String]
 
func _process(delta):
	label.text=focus_array.front()

func _ready():
	focus_array.push_front("Inventory")
	prepare_fishing.connect(update_ui.bind("StartMenu"))

func update_ui(_name:String):
	if(!get_node(_name).visible):#当更新的ui不可见时隐藏此ui并聚焦至前一个ui
		focus_array.push_front(_name)
		get_node(focus_array.front()).show_ui()
	else:
		get_node(focus_array.front()).hide_ui()
		focus_array.pop_front()
		get_node(focus_array.front()).show_ui()
