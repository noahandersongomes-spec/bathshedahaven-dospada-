class_name Player
extends CharacterBody2D

const SPEED := 260.0
const JUMP_VELOCITY := -430.0
const ACCELERATION := 1800.0
const FRICTION := 2400.0
const GRAVITY := 1400.0
const MAX_FALL_SPEED := 900.0
## Falling below this world height respawns the player at the start.
const FALL_LIMIT := 1200.0

@onready var sprite: Sprite2D = $Sprite2D

var spawn_position: Vector2

func _ready() -> void:
	spawn_position = global_position

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y = minf(velocity.y + GRAVITY * delta, MAX_FALL_SPEED)

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction != 0.0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
		sprite.flip_h = direction < 0.0
	else:
		velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)

	move_and_slide()

	if global_position.y > FALL_LIMIT:
		global_position = spawn_position
		velocity = Vector2.ZERO
