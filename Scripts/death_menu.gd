extends Control

func _ready() -> void:
	$Intro/Buttons/LevelStats.text = "Level Reached: " + str(Global.level)
	$Intro/Buttons/EnemiesDefeated.text = "Enemies Defeated: " + str(Global.enemies_defeated)
	$Intro/Buttons/CoinsCollected.text = "Coins Collected: " + str(Global.coins)
	
	Global.update_max_stats()
	
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


	
