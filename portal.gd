class_name Portal
extends Area2D

## Where each level's portal leads. Keyed by the scene that owns the portal.
const LEVEL_CHAIN := {
	"res://main.tscn": "res://levels/level_2.tscn",
	"res://levels/level_2.tscn": "res://levels/level_3.tscn",
	"res://levels/level_3.tscn": "res://levels/end_screen.tscn",
}

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_sprite.play("glow")

func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	var current: String = get_tree().current_scene.scene_file_path
	var next_scene: String = LEVEL_CHAIN.get(current, "")
	if next_scene != "":
		# Defer so we are not removing nodes mid physics-callback.
		get_tree().call_deferred("change_scene_to_file", next_scene)