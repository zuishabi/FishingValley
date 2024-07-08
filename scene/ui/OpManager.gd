extends Control

@onready var line_edit = $VBoxContainer/HBoxContainer/LineEdit
@onready var rich_text_label = $VBoxContainer/RichTextLabel

func _input(event):
	if(event.is_action_pressed("show_op")):
		if(visible):
			self.hide()
			get_tree().paused=false
		else:
			self.show()
			get_tree().paused=true

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

func add_item(object:String):
	Inventory.add_item(ObjectList.find_fish_pole(object))

func _on_button_pressed():
	process_command(line_edit.text)
