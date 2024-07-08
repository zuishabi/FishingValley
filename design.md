# 设计文档

## EventBus事件总线
#### 接口:
load_fight(player:PlayerStats,fish:Fish)
传入玩家数据和鱼资源，使时间总线记录器信息

#### 数据:
player_stats:PlayerStats 玩家的统计信息
fish_stats:FishStats 鱼的统计信息

## Ui
#### 接口：
update_ui(_name:String)
更新当前传入的ui，如果当前聚焦不为此ui，则使ui中的当前聚焦为输入的名字，并记录前一个聚焦ui，同时打开当前ui，如果此ui已打开则关闭此ui显示前一个ui。