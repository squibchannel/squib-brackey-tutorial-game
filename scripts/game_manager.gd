extends Node

var run_time: float = 0.0
var final_time: float = 0.0
var run_active: bool = false
var run_finished: bool = false

var coins_total: int = 30
var coins_collected: int = 0

var bottles_total: int = 12
var broken_bottles: int = 0

var collected_coin_ids: Dictionary = {}
var broken_bottle_ids: Dictionary = {}

var max_lives: int = 3
var lives: int = 3


var hud: Hud = null


func _process(delta: float) -> void:
	if run_active and not run_finished:
		run_time += delta
		update_timer_label()


func register_hud(new_hud: Hud) -> void:
	hud = new_hud
	update_hud()


func unregister_hud(old_hud: Hud) -> void:
	if hud == old_hud:
		hud = null


func start_new_run() -> void:
	run_time = 0.0
	final_time = 0.0

	run_active = true
	run_finished = false

	lives = max_lives
	coins_collected = 0
	broken_bottles = 0
	
	collected_coin_ids.clear()
	broken_bottle_ids.clear()

	update_hud()

	print("New run started")


func resume_after_reload() -> void:
	run_active = true
	run_finished = false

	update_hud()

	print("Run resumed")
	print("Coins still collected: ", coins_collected)
	print("Bottles still broken: ", broken_bottles)
	print("Lives left: ", lives)


func pause_run() -> void:
	run_active = false


func lose_life() -> bool:
	lives -= 1

	if lives <= 0:
		game_over()
		return false

	update_hud()
	return true


func game_over() -> void:
	run_active = false
	run_finished = true

	final_time = run_time

	print("Game Over")
	print("Final time: ", format_time(final_time))


func reset_progress() -> void:
	run_time = 0.0
	final_time = 0.0

	lives = max_lives
	coins_collected = 0
	broken_bottles = 0
	collected_coin_ids.clear()
	broken_bottle_ids.clear()
	update_hud()


func complete_run() -> void:
	if run_finished:
		return

	run_finished = true
	run_active = false

	final_time = run_time

	update_hud()

	print("Run complete! Final time: ", format_time(final_time))
	print("Lives left: " + str(lives))
	
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file("res://scenes/win_scene.tscn")


func add_point(coin_id: String) -> void:
	if run_finished:
		return

	if collected_coin_ids.has(coin_id):
		return

	collected_coin_ids[coin_id] = true
	coins_collected = collected_coin_ids.size()

	if hud != null and is_instance_valid(hud):
		hud.set_total_coins(coins_collected)

	check_objective_complete()


func add_bottle(bottle_id: String) -> void:
	if run_finished:
		return

	if broken_bottle_ids.has(bottle_id):
		return

	broken_bottle_ids[bottle_id] = true
	broken_bottles = broken_bottle_ids.size()

	if hud != null and is_instance_valid(hud):
		hud.set_total_bottles(broken_bottles)

	check_objective_complete()
	
func is_coin_collected(coin_id: String) -> bool:
	return collected_coin_ids.has(coin_id)


func is_bottle_broken(bottle_id: String) -> bool:
	return broken_bottle_ids.has(bottle_id)


func check_objective_complete() -> void:
	if coins_collected >= coins_total and broken_bottles >= bottles_total:
		complete_run()
	else:
		print("Run not complete")


func update_hud() -> void:
	if hud == null or not is_instance_valid(hud):
		return

	hud.set_timer_text(format_time(run_time))
	hud.set_total_lives(lives)
	hud.set_total_bottles(broken_bottles)
	hud.set_total_coins(coins_collected)


func update_timer_label() -> void:
	if hud == null or not is_instance_valid(hud):
		return

	hud.set_timer_text(format_time(run_time))


func format_time(time: float) -> String:
	var minutes := int(time) / 60
	var seconds := int(time) % 60
	var milliseconds := int((time - int(time)) * 100)

	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
