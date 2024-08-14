

# 设计文档

***

# 全局脚本部分

***

## EventBus事件总线
### ==函数==

### ==数据==

***

## FishList
*存放当前鱼（战斗鱼）的列表*

### ==函数==
* **find_fish(fish_name)->fish**
获取字典中的鱼，返回一个鱼
### ==数据==
* fish_list:Dictionary 存放战斗鱼的字典

***

## Inventory
*存放玩家主物品栏的全局管理场景*

### ==函数==
* add_item(object:BaseObject,amount:int=1)->bool
将传入的进行判断，如果传入的物品是工具，就会直接加入到主物品栏中，如果是其他物品中，则会在主物品栏中寻找对应合适的物品加入到其中，方法通过调用对应工具的add_item函数，如果添加成功则返回true，反之返回false
* get_inventory_size()->int
返回当前背包的大小
* find_available_inventory()->int
返回在背包中空闲的位置作为可用位置
### ==信号==
* focus_changed
当玩家的聚焦点切换是发出，更新focused_index对应的ui，也可以用来更新当前聚焦的ui
* inventory_changed(available_inventory:int)
当物品发生改变时发出，传递对应的位置，来更新ui中当前位置
### ==数据==
* inventory:Array[BaseObject]
主物品栏，主要存放玩家的主要工具
* focused_index:**int**
当前聚焦的背包位置，当改变时发出focus_changed信号

***

## ObjectList
*管理游戏中的所有物品*

### ==函数==

* find_object(object_name)->BaseObject
通过输入物品的名称来获得一个物品的副本，所有继承于BaseObject类的物品
* get_item(item_name:String,amount:int=1)->Item
通过输入一个物品的名称以及数量来返回对应数量的物品的副本，适用于item类的物品
### ==数据==
* object_list:Dictionary
存放所有物品的列表

***

## BattleManager
*管理战斗场景的全局场景*

### 数据

| 变量名                | 数据类型    | 描述                                       |
| --------------------- | ----------- | ------------------------------------------ |
| player_stats          | PlayerStats | 存放玩家的数据                             |
| current_fish          | Fish        | 存放鱼的数据，ai以及行动意图               |
| final_loots           | Array[Item] | 战斗结束后的战利品                         |
| start_time & end_time | int         | 记录战斗的开始和结束时间                   |
| cards_inventory       | Array[Card] | 记录卡牌库存，即玩家的所有牌除去手牌和弃牌 |
| discard_hands         | Array[Card] | 记录玩家的弃牌堆                           |

### 函数

| 函数名                                   | 描述                                                         |
| ---------------------------------------- | ------------------------------------------------------------ |
| load_fight(player:PlayerStats,fish:Fish) | 当载入战斗时调用，加载玩家的数据和鱼                         |
| start_fish                               | 当正式开始战斗时调用，先清空战利品，开始计时，并获得一份玩家卡牌的副本，最后切换到battle场景 |
| on_battle_win                            | 当战斗胜利时调用，获得结束时间，获取战利品(未完成)，切换到主场景，并在主场景准备完成后发出battle_win信号，来调出胜利结算界面 |
| on_battle_lose                           | 当战斗失败时调用，获得结束时间，切换到主场景，并在主场景准备完成后发出battle_lose信号，来调出失败界面 |

### 信号

| 信号名                 | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| battle_win             | 当战斗胜利时发出，来调出战斗胜利界面                         |
| battle_lose            | 当战斗失败时发出，来调出战斗失败界面                         |
| main_prepared          | 当主场景准备完成后发出，来获得发出战斗胜利和失败信号的时间点 |
| update_player_stats_ui | 更新玩家的统计数据ui                                         |
| update_buff_ui         | 更新玩家和鱼的buff列表ui                                     |



***

## Picker
*管理获得水池中鱼和战利品表的全局场景*
### ==函数==
* get_fish(pool_name:String)->Fish
通过传入水池的名字来随机获得一条战斗鱼的副本
* get_loot(loot_name:String)->Item
通过传入战利品表的名字来随机获得一件战利品

### ==数据==
* pool_list:Array[FishPool]
  存放鱼池的列表

* loot_list:Array[Loot]
  存放战利品表的列表

  

***

# 类部分

***

## *基础类*---Stats 
*管理玩家和鱼的统计数据的基础类*

### 数据
| 变量名         | 数据类型                      | 描述                                                     |
| -------------- | ----------------------------- | -------------------------------------------------------- |
| max_health     | int                           | 最大生命值                                               |
| base_armor     | int                           | 基础护甲值                                               |
| base_attack    | int                           | 基础攻击值                                               |
| health         | int                           | 当前生命值，当生命值发生改变时，会发出health_changed信号 |
| current_armor  | int                           | 当前护甲值                                               |
| current_attack | int                           | 当前攻击力                                               |
| buff_array     | Array[[Buff](#基础类---Buff)] | 记录当前buff列表                                         |

### 函数

| 函数名                       | 描述                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| reload()                     | 更新buff列表，使所有buff使用次数-1，同时更新统计数据的当前护甲和当前攻击，在卡牌回合开始时调用 |
| process_effect(value:Effect) | 处理收到的effect，首先将effect遍历一遍buff_array，使其作用于buff的apply_effect()函数，最后根据effect进行处理并发出对应信号 |
| add_buff(buff:Buff)          | 创建一个buff的副本，在buff_array中寻找是否存在名字相同的buff，如果存在，则直接将使用次数加一，否则添加此buff |
| process_buff()               | 遍历buff数组，调用所有的buff的apply_buff函数                 |

### 信号

| 信号名                    | 描述                     |
| ------------------------- | ------------------------ |
| health_changed(value:int) | 会传递生命值             |
| attack(value:int)         | 发出攻击信号，表示被攻击 |
| heal(value:int)           | 发出治疗信号，表示被治疗 |

***



##  *拓展Stats*---PlayerStats

*记录玩家统计数据的类*

### 数据
| 变量名                | 数据类型 | 描述                                                         |
| --------------------- | -------- | ------------------------------------------------------------ |
| base_max_endurance    | float    | 基础耐力，每次拉杆会减少对应的耐力，减少的量与force有关，当耐力为0时钓鱼回合结束 |
| base_force            | float    | 基础力量，决定了拉杆的力度以及减少耐力的量                   |
| base_max_mana         | int      | 最大魔力值，决定卡牌回合可出的卡牌数                         |
| current_max_endurance | float    | 当前最大耐力                                                 |
| current_force         | float    | 当前力量                                                     |
| current_mana          | int      | 当前的魔力，改变时会发出mana_changed信号                     |

### 函数

| 函数名   | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| reload() | 首先调用父类的reload函数，接着重新加载自身的魔力值，当前力量以及当前耐力，在卡牌回合开始时调用 |

### 信号

| 信号名                  | 描述               |
| ----------------------- | ------------------ |
| mana_changed(value:int) | 当魔力值改变时发出 |

***



## *拓展Stats*---FishStats 

*记录鱼统计数据的类*

### 数据

| 变量名            | 变量类型 | 描述                                                         |
| ----------------- | -------- | ------------------------------------------------------------ |
| base_max_strength | float    | 基础最大体力，当鱼钩处于鱼的位置时会减少鱼的耐力，否则恢复耐力，当耐力为0时会结束钓鱼回合，否则通过计算鱼和玩家的护甲计算出比例得出对应的伤害 |
| current_strength  | float    | 当前体力                                                     |

### 函数

| 函数名   | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| reload() | 首先调用父类的reload()函数，然后重载自身的体力，在卡牌回合开始时调用 |

***



## *基础类*---Buff

*存放在统计数据中buff_array，存放修改玩家数值的类*

### 数据

| 变量名      | 变量类型  | 描述                                                     |
| ----------- | :-------- | :------------------------------------------------------- |
| use_time    | int       | 代表此buff可以被使用的次数，每次进入到卡牌回合会自动更新 |
| name        | String    | buff的名称                                               |
| texture     | Texture2D | buff的图标                                               |
| description | String    | buff的描述                                               |

### 函数

| 函数名称                                   | 描述                   |
| ------------------------------------------ | ---------------------- |
| apply_buff(object:Stats,value:Effect=null) | 对传入的object应用buff |

***



## 基础类---BaseObject

*所有物品的基类，有物品图标，物品名称，物品描述属性，以及更新和获取副本方法*

### 数据

| 变量名             | 变量类型  | 描述       |
| ------------------ | --------- | ---------- |
| object_texture     | Texture2D | 物品的图标 |
| object_name        | String    | 物品的名称 |
| object_description | String    | 物品的描述 |

### 函数

| 函数名                         | 描述                                                         |
| ------------------------------ | ------------------------------------------------------------ |
| _update()                      | 在物品获得副本时更新物品，例如对于继承于                     |
| object_duplicate()->BaseObject | 返回物品的一个副本，首先会获得一个当前物品的深拷贝，然后调用其update函数进行更新，最后返回更新的函数 |

# 场景

***

## 战斗场景

### 主战斗场景



***



## Ui

*存放所有主场景的ui*

### ==函数==

* **update_ui(_name:String)**
  更新当前传入的ui，如果当前聚焦不为此ui，则使ui中的当前聚焦为输入的名字，并记录前一个聚焦ui，同时打开当前ui，如果此ui已打开则关闭此ui显示前一个ui。一个ui如果能进行此操作需要具备show_ui以及hide_ui函数来管理ui的启动和关闭

***

## Player

**玩家场景**

### ==函数==

### ==信号==

* fishing_request(pos:Vector2)
  发出一个钓鱼的请求，传输落点位置
* cancel_fish
  当取消钓鱼时发出的信号
* catch_fish
  当抓到鱼时发出

### ==数据==

* speed 当前玩家的速度
* face_direction 当前面朝的方向
* player_stats 玩家的统计信息