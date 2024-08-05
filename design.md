# 设计文档
***

# 全局脚本部分

***

## EventBus事件总线
#### ==函数==

#### ==数据==

***

## Ui
*存放所有主场景的ui*

#### ==函数==
* **update_ui(_name:String)**
更新当前传入的ui，如果当前聚焦不为此ui，则使ui中的当前聚焦为输入的名字，并记录前一个聚焦ui，同时打开当前ui，如果此ui已打开则关闭此ui显示前一个ui。一个ui如果能进行此操作需要具备show_ui以及hide_ui函数来管理ui的启动和关闭

***

## Player
**玩家场景**

#### ==函数==

#### ==信号==
* fishing_request(pos:Vector2)
发出一个钓鱼的请求，传输落点位置
* cancel_fish
当取消钓鱼时发出的信号
* catch_fish
当抓到鱼时发出
#### ==数据==
* speed 当前玩家的速度
* face_direction 当前面朝的方向
* player_stats 玩家的统计信息

***

## FishList
*存放当前鱼（战斗鱼）的列表*

#### ==函数==
* **find_fish(fish_name)->fish**
获取字典中的鱼，返回一个鱼
#### ==数据==
* fish_list:Dictionary 存放战斗鱼的字典

***

## Inventory
*存放玩家主物品栏的全局管理场景*

#### ==函数==
* add_item(object:BaseObject,amount:int=1)->bool
将传入的进行判断，如果传入的物品是工具，就会直接加入到主物品栏中，如果是其他物品中，则会在主物品栏中寻找对应合适的物品加入到其中，方法通过调用对应工具的add_item函数，如果添加成功则返回true，反之返回false
* get_inventory_size()->int
返回当前背包的大小
* find_available_inventory()->int
返回在背包中空闲的位置作为可用位置
#### ==信号==
* focus_changed
当玩家的聚焦点切换是发出，更新focused_index对应的ui，也可以用来更新当前聚焦的ui
* inventory_changed(available_inventory:int)
当物品发生改变时发出，传递对应的位置，来更新ui中当前位置
#### ==数据==
* inventory:Array[BaseObject]
主物品栏，主要存放玩家的主要工具
* focused_index:**int**
当前聚焦的背包位置，当改变时发出focus_changed信号

***

## ObjectList
*管理游戏中的所有物品*

#### ==函数==

* find_object(object_name)->BaseObject
通过输入物品的名称来获得一个物品的副本，所有继承于BaseObject类的物品
* get_item(item_name:String,amount:int=1)->Item
通过输入一个物品的名称以及数量来返回对应数量的物品的副本，适用于item类的物品
#### ==数据==
* object_list:Dictionary
存放所有物品的列表

***

## BattleManager
*管理战斗场景的全局场景*

#### ==函数==
* load_fight(player:PlayerStats,fish:Fish)
在战斗管理场景中加载玩家的统计数据以及鱼的资源
* start_fish()
开始钓鱼，启动计时器并清空战利品数组，同时转换场景至战斗场景
* on_battle_win()
当战斗胜利时调用，当等待场景更换完毕后发出战斗胜利信号
* on_battle_lose()
当战斗结束时调用，当等待场景更换完毕后发出战斗失败信号
#### ==信号==
* battle_win
当更换场景结束时发出，发送给主场景
* battle_lose
当更换场景结束时发出，发出给主场景
* main_prepared
当主场景准备完成后发出此信号，传递给BattleManager说明更换场景结束
#### ==数据==
* player_stats:PlayerStats
记录玩家的统计数据
* current_fish:Fish
记录当前战斗鱼的统计数据
* final_loots:Array[Item]
记录最后的战利品列表

***

## Picker
*管理获得水池中鱼和战利品表的全局场景*
#### ==函数==
* get_fish(pool_name:String)->Fish
通过传入水池的名字来随机获得一条战斗鱼的副本
* get_loot(loot_name:String)->Item
通过传入战利品表的名字来随机获得一件战利品

#### ==数据==
* pool_list:Array[FishPool]
  存放鱼池的列表

* loot_list:Array[Loot]
  存放战利品表的列表

  

***

# 类部分

***

## Stats ==基础类==
*管理玩家和鱼的统计数据的基础类*

#### ==数据==
* max_health 最大生命值
* health 当前生命值

***

## PlayerStats ==拓展于[Stats](#stats-基础类)==
*记录玩家统计数据的类*

#### ==数据==
* base_max_endurance:float 记录玩家的最大耐力
* current_max_endurance:float 记录玩家当前回合的最大耐力
* base_max_force:float 记录玩家最大力量
* current_force:float 记录玩家当前回合的力量
* base_max_mana:int 记录玩家最大的魔力值
* current_mana:int 记录玩家当前回合最大的魔力值

#### ==函数==

* reload()

  重新加载玩家的数据，将当前回合的数据更新

***

## FishStats ==拓展于[Stats](#stats-基础类)==
*记录鱼统计数据的类*

***

# 场景

***

## 战斗场景