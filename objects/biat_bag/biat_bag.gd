class_name BiatBag
extends BaseContainer

var current_biat:Item
var current_biat_id:int

func _update():
	inventory.resize(max_size)

func add_item(item:Biat,amount:int)->bool:
	for i:Biat in inventory:
		if(i!=null&&i.object_name==item.object_name):
			i.amount+=amount
			print("找到相同鱼饵")
			return true
	print("未找到相同鱼饵")
	if(get_current_size()==max_size):
		print("背包已到达最大值")
		return false
	else:
		print("背包有空余，成功添加")
		item.amount=amount
		inventory[get_available_inventory()]=item
		return true

func find_item(item:Biat,amount:int) -> bool:
	for i:Biat in inventory:
		if i != null && i.object_name == item.object_name && i.amount >= amount:
			return true
	return false

func delete_item(item:Biat,amount:int):
	for i:Biat in inventory:
		if i != null && i.object_name == item.object_name:
			i.amount -= amount
			if i.amount == 0:
				inventory.erase(i)

func equip_biat(id:int):
	current_biat_id=id
	current_biat=inventory[id]

func unequip_biat():
	current_biat=null
