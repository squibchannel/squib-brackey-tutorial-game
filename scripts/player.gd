extends CharacterBody2D


const SPEED: float = 140.0
const JUMP_VELOCITY: float = -315.0

const ROLL_SPEED: float = 250.0
const ROLL_DURATION: float = 0.25

@onready var player: CharacterBody2D = $"."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_dead: bool = false

@export var is_rolling: bool = false
var roll_timer: float = 0.0

var facing_direction: int = 1
var roll_direction: int = 1


func _ready() -> void:
	player.add_to_group("player", true)


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")

	# Start roll.
	if Input.is_action_just_pressed("roll") and is_on_floor() and not is_rolling:
		start_roll()

	# Rolling movement.
	# While rolling, ignore left/right input.
	if is_rolling:
		roll_timer -= delta
		velocity.x = roll_direction * ROLL_SPEED

		if roll_timer <= 0.0:
			is_rolling = false

		move_and_slide()
		return

	# Update facing direction only when NOT rolling.
	if direction > 0:
		facing_direction = 1
		animated_sprite.flip_h = false
	elif direction < 0:
		facing_direction = -1
		animated_sprite.flip_h = true

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Normal movement.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Play animations.
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	move_and_slide()


func start_roll() -> void:
	is_rolling = true
	roll_timer = ROLL_DURATION

	# Lock in the direction at the moment the roll starts.
	roll_direction = facing_direction

	# Keep sprite facing the roll direction.
	animated_sprite.flip_h = roll_direction < 0

	velocity.y = 0
	animated_sprite.play("roll")
