class_name CoinSpawner
extends Node2D

## Scatters a few coins randomly on top of the level's platforms at startup.
const COIN_SCENE := preload("res://coin.tscn")

@export var coins_per_level: int = 6

func _ready() -> void:
	var ground: TileMapLayer = get_parent().get_node_or_null("Ground") as TileMapLayer
	if ground == null:
		return

	# A "surface" is any solid cell with empty space directly above it.
	var surfaces: Array[Vector2i] = []
	for cell in ground.get_used_cells():
		if ground.get_cell_source_id(cell + Vector2i.UP) == -1:
			surfaces.append(cell)
	if surfaces.is_empty():
		return

	var rng := RandomNumberGenerator.new()
	rng.randomize()
	var count: int = mini(coins_per_level, surfaces.size())
	var chosen: Array[Vector2i] = []
	while chosen.size() < count:
		var pick: Vector2i = surfaces[rng.randi_range(0, surfaces.size() - 1)]
		if not chosen.has(pick):
			chosen.append(pick)

	# Sort left-to-right just so it reads naturally, then place a coin above each.
	chosen.sort_custom(func(a: Vector2i, b: Vector2i) -> bool: return a.x < b.x)
	for cell in chosen:
		var coin: Node2D = COIN_SCENE.instantiate()
		coin.position = ground.map_to_local(cell + Vector2i.UP) + Vector2(0, 6)
		add_child(coin)