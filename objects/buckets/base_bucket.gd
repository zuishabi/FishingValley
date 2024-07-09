class_name Bucket
extends BaseContainer

func _update():
	inventory.resize(max_size)
