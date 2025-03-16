extends Node

var max_health : int = 8
var health = max_health
var coins : int = 0
var level : int = 1
var seed : int = 123456
var enemies_defeated : int = 0
var max_level = 0
var max_coins = 0
var max_enemies_defeated = 0

func update_max_stats():
	if level > max_level:
		max_level = level
	if coins > max_coins:
		max_coins = coins
	if enemies_defeated > max_enemies_defeated:
		max_enemies_defeated = enemies_defeated
