extends Node2D

var inside_width : int = 9
var inside_height : int = 9

@onready var Generation : Node

@export var enemy_node : PackedScene
@export var coin_node : PackedScene
@export var heart_node : PackedScene
@export var key_node : PackedScene
@export var exit_door_node : PackedScene

var used_position : Array

func _ready():
	if Generation:
		generate_interior()

func north():
	$NorthDoor.visible = true
	$NorthWall.queue_free()

func south():
	$SouthDoor.visible = true
	$SouthWall.queue_free()

func east():
	$EastDoor.visible = true
	$EastWall.queue_free()

func west():
	$WestDoor.visible = true
	$WestWall.queue_free()

func generate_interior() -> void:
	if randf_range(0, 1) < Generation.enemy_spawn_chance:
		spawn_node(enemy_node, 1, Generation.max_enemies_per_room)
	if randf_range(0, 1) < Generation.coin_spawn_chance:
		spawn_node(coin_node, 1, Generation.max_coins_per_room)
	if randf_range(0, 1) < Generation.heart_spawn_chance:
		spawn_node(heart_node, 1, Generation.max_hearts_per_room)

func spawn_node(node_scene : PackedScene, min_ins : int = 0, max_ins : int = 0):
	var num : int = 1
	if min_ins != 0 or max_ins != 0:
		num = randi_range(min_ins, max_ins)
	
	for i in range(num):
		var node_obj = node_scene.instantiate()
		var pos : Vector2 = Vector2(48 * randi_range(2, inside_width - 1) - 24, 48 * randi_range(2, inside_height - 1) - 24)
		while pos in used_position:
			pos = Vector2(48 * randi_range(2, inside_width - 1) - 24, 48 * randi_range(2, inside_height - 1) - 24)
		
		node_obj.position = pos
		used_position.append(pos)
		add_child(node_obj)
	if node_scene == enemy_node:
		get_tree().get_first_node_in_group("Enemy_Manager").check_enemies()
