class_name Coin
extends Area2D

## Total coins collected during this run. Static so it survives scene changes.
static var count: int = 0

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if _sprite.sprite_frames and _sprite.sprite_frames.has_animation("spin"):
		_sprite.play("spin")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		count += 1
		queue_free()