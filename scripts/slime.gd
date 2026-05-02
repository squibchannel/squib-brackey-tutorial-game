extends Node2D

const SPEED = 30
var direction = 1
var is_spawning = true

@onready var ray_cast_2d_right: RayCast2D = $"RayCast2D-Right"
@onready var ray_cast_2d_2_left: RayCast2D = $"RayCast2D2-Left"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_anim_finsihed():
	if animated_sprite_2d.animation == "spawn":
		is_spawning = false

func _ready() -> void:
	if is_spawning:
		animated_sprite_2d.play("spawn")
		animated_sprite_2d.animation_finished.connect(_on_anim_finsihed)

func _process(delta: float) -> void:
	if is_spawning:
		return
		
	animated_sprite_2d.play("idle")
	
	if ray_cast_2d_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_2d_2_left.is_colliding():
		direction = 1	
		animated_sprite_2d.flip_h = false
	
	position.x += direction * SPEED * delta
	
	
