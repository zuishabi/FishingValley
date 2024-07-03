extends Control

func update_ui(pos:Vector2):
	if self.visible:
		hide()
	else:
		self.position=pos
		show()
