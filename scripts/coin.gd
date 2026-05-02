#extends Area2D
#
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#
#
#func _on_body_entered(body: Node2D) -> void:
	#GameManager.add_point()
	#animation_player.play("pickup")

extends Area2D

@export var coin_id: String = ""
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if coin_id == "":
		coin_id = get_parent().name
		print(coin_id)

	if GameManager.is_coin_collected(coin_id):
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	GameManager.add_point(coin_id)
	animation_player.play("pickup")
	await animation_player.animation_finished
	queue_free()
