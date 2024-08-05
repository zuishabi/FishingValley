extends Control

@onready var line_edit = $VBoxContainer/HBoxContainer/LineEdit
@onready var rich_text_label = $VBoxContainer/RichTextLabel
@onready var ui = $".."
var can_esc:bool=true

func _input(event):
	if(event.is_action_pressed("show_op")&&(ui.focus_array.front()=="Inventory"||ui.focus_array.front()=="OpManager")):
		ui.update_ui("OpManager")

func show_ui():
	self.show()
	get_tree().paused=true

func hide_ui():
	self.hide()
func process_command(command:String):
	if(command!=""):
		var parts=command.split(" ")
		if parts.size()<=0:
			return
		var cmd:String=parts[0]
		var args=parts.slice(1,parts.size())
		if not has_method(cmd):
			push_error("没有找到匹配的方法:",cmd)
			add_information("未找到此方法")
			line_edit.clear()
			return
		callv(cmd,args)
		line_edit.clear()

func add_information(text:String):
	rich_text_label.add_text(Time.get_time_string_from_system()+':'+text)
	rich_text_label.newline()

func add_item(object:String,amount:String="1"):
	if(Inventory.add_item(ObjectList.find_object(object),int(amount))):
		add_information("成功添加"+object)
	else:
		add_information("添加失败")

func rookie():
	Inventory.add_item(ObjectList.find_object("bamboo_pole"))
	Inventory.add_item(ObjectList.find_object("biat_bag"))
	Inventory.add_item(ObjectList.find_object("barrel"))
	Inventory.add_item(ObjectList.find_object("cards_bag"))

func _on_button_pressed():
	process_command(line_edit.text)
