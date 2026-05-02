extends Node2D

@export var bottle_id: String = ""

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $AnimatableBody2D/CollisionShape2D

var breakable := false
var broken := false
var player_ref: CharacterBody2D = null


func _ready() -> void:
	if bottle_id == "":
		bottle_id = name

	if GameManager.is_bottle_broken(bottle_id):
		set_already_broken_state()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !broken:
		breakable = true
		player_ref = body as CharacterBody2D

		if player_ref != null and player_ref.is_rolling:
			break_bottle()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player_ref and !broken:
		breakable = false
		player_ref = null


func _process(delta: float) -> void:
	if breakable and !broken and player_ref != null and player_ref.is_rolling:
		break_bottle()


func break_bottle() -> void:
	if broken:
		return

	broken = true
	breakable = false

	GameManager.add_bottle(bottle_id)

	animated_sprite_2d.play("breaking")
	collision_shape_2d.set_deferred("disabled", true)


func set_already_broken_state() -> void:
	broken = true
	breakable = false

	collision_shape_2d.set_deferred("disabled", true)

	if animated_sprite_2d.sprite_frames.has_animation("broken"):
		animated_sprite_2d.play("broken")
	else:
		var final_frame := animated_sprite_2d.sprite_frames.get_frame_count("breaking") - 1
		animated_sprite_2d.animation = "breaking"
		animated_sprite_2d.frame = final_frame
		animated_sprite_2d.pause()
