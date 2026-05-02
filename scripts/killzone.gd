extends Area2D

@onready var timer: Timer = $Timer

var triggered := false


func _on_body_entered(body: Node2D) -> void:
	if triggered:
		return

	if not body.is_in_group("player"):
		return

	triggered = true

	print("you died")

	Engine.time_scale = 0.5
	GameManager.pause_run()

	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0

	var still_has_lives := GameManager.lose_life()

	if still_has_lives:
		get_tree().reload_current_scene()
	else:
		# Pick what you want here.
		# Example: reload level fresh after full reset.
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

		# Or send player back to menu:
		# get_tree().change_scene_to_file("res://ui/menus/start_menu.tscn")
