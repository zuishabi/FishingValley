extends Node

signal focus_changed
signal inventory_changed

var inventory:Array[BaseObject]
var focused_index:int:
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

func find_item(item:Item,amount:int) -> bool:
	if item == null:
		print("寻找物品传入错误")
		return false
	else:
		if item is Biat:
			return find_biat(item,amount)
		elif item is FishItem:
			return find_fish(item)
		elif item is Card:
			return find_card(item)
	return true

func delete_item(object:BaseObject,amount:int):
	if object == null:
		print("删除物品传入错误")
	else:
		if object is Biat:
			delete_biat(object,amount)
		elif object is FishItem:
			delete_fish(object)
		elif object is Card:
			delete_card(object)

#返回卡牌包的所有卡牌的副本
func get_card_inventory()->Array[Card]:
	var array:Array[Card]
	for i in inventory:
		if i is CardsBag:
			for j in i.inventory:
				if(j!=null):
					array.append(j.duplicate(1))
	return array

#-------------------------------------------添加部分-------------------------------------------------
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

#-------------------------------------------寻找部分-------------------------------------------------
func find_biat(biat:Biat,amount:int) -> bool:
	for i in inventory:
		if i is BiatBag:
			return i.find_item(biat,amount)
	return false

func find_fish(fish:FishItem) -> bool:
	for i in inventory:
		if i is Bucket:
			return i.find_item(fish)
	return false

func find_card(card:Card) -> bool:
	for i in inventory:
		if i is CardsBag:
			return i.find_item(card)
	return false
#-------------------------------------------删除部分-------------------------------------------------
func delete_biat(biat:Biat,amount:int):
	for i in inventory:
		if i is BiatBag:
			i.delete_item(biat,amount)

func delete_fish(fish:FishItem):
	for i in inventory:
		if i is Bucket:
			i.delete_item(fish)

func delete_card(card:Card):
	for i in inventory:
		if i is CardsBag:
			i.delete_item(card)
#-------------------------------------------辅助函数-------------------------------------------------
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
	focused_index = 0
