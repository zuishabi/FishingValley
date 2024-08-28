class_name DiaUnit
extends Resource

enum TYPE {SELECT,SUBMIT,GET,NORMAL}

## 当前对话体的id
@export var id:int
## 下一个对话体的id
@export var next_id:int
## 作为提交分支，当提交成功，将next_id设置为此id
@export var true_id:int
## 作为提交分支，当提交失败，将next_id设置为此id
@export var false_id:int

## 对话体内容
@export_multiline var content:String
## 对话体左侧的图片
@export var dia_texture:Texture2D

## 对话体的类型
@export var dia_type:TYPE
## 下一个对话体的类型
@export var next_type:TYPE

@export var items:Dictionary
