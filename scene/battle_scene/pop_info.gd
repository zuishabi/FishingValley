extends PanelContainer

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

var target_pos:Vector2

func pop(info:String,pos:Vector2):
	rich_text_label.text = "[center]"+info
	target_pos = pos
	self.global_position = target_pos
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self,"global_position",target_pos + Vector2.UP*30,1)
	tween.tween_property(self,"modulate",Color(1,1,1,0),1)
	await tween.finished
	self.queue_free()
