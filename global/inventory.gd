extends Node

signal focus_changed
signal inventory_changed

var inventory:Array[BaseObject]
var focused_index:int=0:
	set(value):
		focused_index=value
		focus_changed.emit()

func _ready():
	inventory.resize(7)
	Saver.load_request.connect(load_game)

func change_index(direction:int):
	focused_index=(focused_index+direction)%7

func add_item(object:BaseObject,amount:int=1)->bool:
	if(object==null):
		EventBus.emit_test(["传入个空值"])
		return false
	else:
		if(object is Biat):
			if add_biat(object,amount):
				print("成功添加至鱼饵袋")
		if(object is FishItem):
			if add_fish(object):
				print("成功添加至木桶")
		if(object is Card):
			if add_card(object):
				print("成功添加到卡牌包")
		if(object is Tool):
			if add_tool(object):
				print("成功添加工具")
		return true

#返回卡牌包的所有卡牌的副本
func get_card_inventory()->Array[Card]:
	var array:Array[Card]
	for i in inventory:
		if i is CardsBag:
			for j in i.inventory:
				if(j!=null):
					array.append(j.duplicate(1))
	return array

#--------------------------------------------辅助函数-----------------------------------------------#

func add_tool(tool:Tool) -> bool:
	if tool is BiatBag:
		for i:Tool in inventory:
			if i != null && i is BiatBag:
				print("已存在鱼饵包")
				return false
	elif tool is Bucket:
		for i:Tool in inventory:
			if i != null && i is Bucket:
				print("已存在水桶")
				return false
	elif tool is CardsBag:
		for i:Tool in inventory:
			if i != null && i is CardsBag:
				print("已存在卡牌包")
				return false
	elif tool is FishingPole:
		for i:Tool in inventory:
			if i != null && i is FishingPole:
				print("已存在鱼竿")
				return false
	var available_inventory:int = find_available_inventory()
	inventory[available_inventory] = tool
	inventory_changed.emit(available_inventory)
	focus_changed.emit()
	return true

func add_card(card:Card)->bool:
	for i in inventory:
		if i is CardsBag:
			return i.add_card(card)
	return false

func add_biat(biat:Biat,amount:int)->bool:
	for i in inventory:
		if i is BiatBag:
			return i.add_item(biat,amount)
	return false

func add_fish(fish:FishItem)->bool:
	for i in inventory:
		if i is Bucket:
			return i.add_item(fish)
	return false

func get_inventory_size()->int:
	var current_size:int=0
	for i in inventory:
		if i != null:
			current_size+=1
	return current_size

func find_available_inventory()->int:
	for i in inventory.size():
		if inventory[i]==null:
			return i
	return -1

func load_game(saved_game:Archiving):
	self.inventory = saved_game.inventory
