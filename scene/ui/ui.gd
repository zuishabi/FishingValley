extends CanvasLayer

func update_ui(_name:String,pos:Vector2=Vector2.ZERO):
	get_node(_name).update_ui(pos)
