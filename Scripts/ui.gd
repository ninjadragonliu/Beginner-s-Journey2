extends CanvasLayer

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var Generation : Node = $"../Generation"

@onready var grid : PackedScene = load("res://Nodes/mini_map_grid.tscn")

func _ready() -> void:
	generate_mini_map()

func _process(delta: float) -> void:
	$StatBar/Coins.text = str(Global.coins)
	
	# handle key
	if player.has_key:
		$StatBar/KeySprite.modulate = "ffffff"
	else:
		$StatBar/KeySprite.modulate = "ffffff32"
		
	# handle hearts
	match Global.health:
		8:
			$"HealthBar/Heart 1".frame = 2
			$"HealthBar/Heart 2".frame = 2
			$"HealthBar/Heart 3".frame = 2
			$"HealthBar/Heart 4".frame = 2
		7:
			$"HealthBar/Heart 1".frame = 2
			$"HealthBar/Heart 2".frame = 2
			$"HealthBar/Heart 3".frame = 2
			$"HealthBar/Heart 4".frame = 1
		6:
			$"HealthBar/Heart 1".frame = 2
			$"HealthBar/Heart 2".frame = 2
			$"HealthBar/Heart 3".frame = 2
			$"HealthBar/Heart 4".frame = 0
		5:
			$"HealthBar/Heart 1".frame = 2
			$"HealthBar/Heart 2".frame = 2
			$"HealthBar/Heart 3".frame = 1
			$"HealthBar/Heart 4".frame = 0
		4:
			$"HealthBar/Heart 1".frame = 2
			$"HealthBar/Heart 2".frame = 2
			$"HealthBar/Heart 3".frame = 0
			$"HealthBar/Heart 4".frame = 0
		3:
			$"HealthBar/Heart 1".frame = 2
			$"HealthBar/Heart 2".frame = 1
			$"HealthBar/Heart 3".frame = 0
			$"HealthBar/Heart 4".frame = 0
		2:
			$"HealthBar/Heart 1".frame = 2
			$"HealthBar/Heart 2".frame = 0
			$"HealthBar/Heart 3".frame = 0
			$"HealthBar/Heart 4".frame = 0
		1:
			$"HealthBar/Heart 1".frame = 1
			$"HealthBar/Heart 2".frame = 0
			$"HealthBar/Heart 3".frame = 0
			$"HealthBar/Heart 4".frame = 0
		0:
			$"HealthBar/Heart 1".frame = 0
			$"HealthBar/Heart 2".frame = 0
			$"HealthBar/Heart 3".frame = 0
			$"HealthBar/Heart 4".frame = 0
	
	$MiniMap/Label.text = "Level" + str(Global.level)
	update_mini_map()
	

func update_mini_map() -> void:
	var pos : Vector2i = (player.global_position / 816)
	var panels = $MiniMap/GridContainer.get_children()
	
	for panel in panels:
		if panel.is_room:
			panel.modulate = "ffffff"
		if panel.pos == pos:
			panel.modulate = "007a27"


func generate_mini_map() -> void:
	$MiniMap/GridContainer.columns = Generation.map_width
	for i in range(Generation.map_height):
		for j in range(Generation.map_width):
			var panel = grid.instantiate()
			if Generation.map[j][i] == false:
				panel.modulate = "ffffff00"
			else:
				panel.is_room = true
			panel.pos = Vector2i(j, i)
			$MiniMap/GridContainer.add_child(panel)
