# 设计文档

## EventBus事件总线
#### 接口:

#### 数据:

## Ui
#### 接口：
update_ui(_name:String)
更新当前传入的ui，如果当前聚焦不为此ui，则使ui中的当前聚焦为输入的名字，并记录前一个聚焦ui，同时打开当前ui，如果此ui已打开则关闭此ui显示前一个ui。

## Player
#### 接口:

#### 信号:
fishing_request(pos:Vector2)
发出一个钓鱼的请求，传输落点位置

cancel_fish
当取消钓鱼时发出的信号

catch_fish
当抓到鱼时发出

#### 数据:
speed 当前玩家的速度
face_direction 当前面朝的方向
player_stats 玩家的统计信息
