extends Node

#-----------------------------------------玩家-------------------------------------------------------
signal leave_fishing	#发出此信号后玩家离开钓鱼状态

#-----------------------------------------对话------------------------------------------------------
signal dia_request(dia_pack:DiaPack)

#-----------------------------------------调试------------------------------------------------------
func emit_test(information:Array[String]):
	print("---------------------------------------------------------------------------------------")
	var mixed_information:String
	for i:String in information:
		mixed_information += i
	print(mixed_information)
