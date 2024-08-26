extends CanvasLayer

signal prepare_fishing

@onready var label = $Inventory/Label

var focus_array:Array[String]

func _process(delta):
	label.text=focus_array.front()

func _ready():
	for i in get_children():
		i.hide()
	update_ui("Inventory")
	prepare_fishing.connect(update_ui.bind("StartMenu"))

func update_ui(_name:String):
	if(!get_node(_name).visible):#当更新的ui不可见时隐藏此ui并聚焦至前一个ui
		focus_array.push_front(_name)
		get_node(focus_array.front()).show_ui()
	else:
		get_node(focus_array.front()).hide_ui()
		focus_array.pop_front()
		get_node(focus_array.front()).show_ui()

func _unhandled_input(event):
	if(event.is_action_pressed("esc")):
		if(get_node(focus_array.front()).can_esc):
			update_ui(focus_array.front())
		elif focus_array.front() == "Inventory":
			update_ui("InsideMenu")
