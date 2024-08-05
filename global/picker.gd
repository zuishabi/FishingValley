extends Node

@export var pool_list:Array[FishPool]
@export var loot_list:Array[Loot]

func find_pool(pool_name:String)->int:
	for i in pool_list.size():
		if(pool_list[i].pool_name==pool_name):
			return i
	return 0

func fish_sort_ascending(a:FishUnit, b:FishUnit):
	if a.weight < b.weight:
		return true
	return false

func get_fish(pool_name:String)->Fish:
	var target_pool:FishPool=pool_list[find_pool(pool_name)]
	target_pool.fish_list.sort_custom(fish_sort_ascending)
	var temp_array:Array[int]
	var sum_weight:int=0
	temp_array.resize(target_pool.fish_list.size())
	for i in target_pool.fish_list.size():
		sum_weight+=target_pool.fish_list[i].weight
		if i>=1:
			temp_array[i]=target_pool.fish_list[i].weight+temp_array[i-1]
		else:
			temp_array[i]=target_pool.fish_list[i].weight
	var current_value:int=randi_range(1,sum_weight)
	var target_fish:Fish
	for i in temp_array.size():
		if(current_value<=temp_array[i]):
			var current_fish:Fish=FishList.find_fish(target_pool.fish_list[i].fish_name)
			if(current_fish.exist()):
				target_fish=current_fish
				break
	return target_fish.duplicate(true)

func loot_sort_ascending(a:LootUnit,b:LootUnit):
	if a.weight < b.weight:
		return true
	return false

func find_loot(loot_name:String)->Loot:
	for i in loot_list:
		if i.loot_name==loot_name:
			return i
	return null

func get_loot(loot_name:String)->Item:
	var current_loot:Loot=find_loot(loot_name)
	if(current_loot==null):
		return null
	else:
		return null
