extends PanelContainer

@onready var label = $Label
var initial_position:Vector2

func _ready():
	self.hide()
	initial_position=global_position
	
func show_tips(content:String):
	label.text=content
	self.show()
	var tween=create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_parallel()
	tween.tween_property(self,"global_position",initial_position+Vector2.UP*80,0.5).from(initial_position)
	tween.tween_property(self,"modulate",Color(1,1,1,0.5),0.5).from(Color(1,1,1,1))
	await tween.finished
	self.hide()
