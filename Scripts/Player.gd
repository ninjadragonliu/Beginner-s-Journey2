extends CharacterBody2D

var has_key : bool = false

signal player_moved

func _physics_process(delta):
	player_input()
	
func player_input() -> void:
	if Input.is_action_just_pressed("move_right"):
		velocity = Vector2.RIGHT
		move(velocity)
	elif Input.is_action_just_pressed("move_up"):
		velocity = Vector2.UP
		move(velocity)
	elif Input.is_action_just_pressed("move_left"):
		velocity = Vector2.LEFT
		move(velocity)
	elif Input.is_action_just_pressed("move_down"):
		velocity = Vector2.DOWN
		move(velocity)
	
	if Input.is_action_just_pressed("attack_right"):
		try_attack(Vector2.RIGHT)
	if Input.is_action_just_pressed("attack_left"):
		try_attack(Vector2.LEFT)
	if Input.is_action_just_pressed("attack_up"):
		try_attack(Vector2.UP)
	if Input.is_action_just_pressed("attack_down"):
		try_attack(Vector2.DOWN)

func move(direction: Vector2) -> void:
	var space_rid = get_world_2d().space
	var space_state = PhysicsServer2D.space_get_direct_state(space_rid)
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(48, 48) * direction)
	var result = space_state.intersect_ray(query)
	
	if result:
		if result.collider.is_in_group("Wall"):
			return
	
	$SFX.stream = load("res://Assets/SFX/walk.wav")
	$SFX.play()
	position += 48 * direction
	player_moved.emit()

func try_attack(direction: Vector2) -> void:
	var space_rid = get_world_2d().space
	var space_state = PhysicsServer2D.space_get_direct_state(space_rid)
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(48, 48) * direction)
	var result = space_state.intersect_ray(query)
	
	if result:
		if result.collider.is_in_group("Enemy"):
			result.collider.take_damage(1)

func take_damage(damage_taken : int) -> void:
	Global.health -= damage_taken
	
	$AnimationPlayer.play("Hit")
	$SFX.stream = load("res://Assets/SFX/Hit.wav")
	$SFX.play()
	
	if Global.health <= 0:
		Sfx.get_child(4).play()
		get_tree().change_scene_to_file("res://Scenes/death_menu.tscn")
	
