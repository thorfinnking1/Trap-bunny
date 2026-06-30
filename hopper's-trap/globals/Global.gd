extends Node

var InLvl : bool = false
var sounddb : int = 0
var player_position:Vector2i

var levels:Dictionary[int,Array]={0:["[b][color=black][wave]hop-n-run","[b][color=green][wave]easy",0],
								1:["[b][color=black][wave]shot-a-bun","[b][color=blue][wave]mid",0],
								2:["[b][color=black][wave]hop-n-run 2","[b][color=blue][wave]mid",0],
								3:["[b][color=black][wave]can't bear","[b][color=green][wave]easy",0]}
