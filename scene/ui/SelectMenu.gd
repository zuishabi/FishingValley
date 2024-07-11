extends PanelContainer

@onready var equip = $VBoxContainer/Equip
@onready var container_inventory = $".."

var id:int
var container:BaseContainer

func init():
	equip.hide()

func update_menu(selected_id:int,current_container:BaseContainer):
	init()
	id=selected_id
	container=current_container
	if current_container.inventory[selected_id] is Biat:
		if(equip.pressed.is_connected(equip_biat)):
			equip.pressed.disconnect(equip_biat)
		if(equip.pressed.is_connected(unequip_biat)):
			equip.pressed.disconnect(unequip_biat)
		container=current_container as BiatBag
		if container.current_biat!=null&&selected_id==container.current_biat_id:
			equip.text="卸下"
			equip.pressed.connect(unequip_biat)
		else:
			equip.text="装备"
			equip.pressed.connect(equip_biat)
		equip.show()

func equip_biat():
	container=container as BiatBag
	container.equip_biat(id)
	Inventory.focus_changed.emit()
	container_inventory.disselect()
	container_inventory.update_equiped()

func unequip_biat():
	container=container as BiatBag
	container.unequip_biat()
	Inventory.focus_changed.emit()
	container_inventory.disselect()
	container_inventory.update_equiped()

func _on_cancel_pressed():
	container_inventory.disselect()

func _on_details_pressed():
	container_inventory.disselect()

func _on_throw_pressed():
	container_inventory.disselect()
