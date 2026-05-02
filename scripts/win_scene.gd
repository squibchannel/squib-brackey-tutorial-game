extends Control

@export_file("*.tscn") var game_scene_path: String = "res://scenes/game.tscn"
@export_file("*.tscn") var main_menu_scene_path: String = "res://scenes/start_menu.tscn"

@onready var time_label: Label = %TimeLabel
@onready var lives_label: Label = %LivesLabel
@onready var restart_button: Button = %RestartButton
@onready var main_menu_button: Button = %MainMenuButton


func _ready() -> void:
	time_label.text = "Time: " + GameManager.format_time(GameManager.final_time)
	lives_label.text = "Lives Left: " + str(GameManager.lives)

	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

	restart_button.grab_focus()


func _on_restart_pressed() -> void:
	GameManager.start_new_run()
	get_tree().change_scene_to_file(game_scene_path)


func _on_main_menu_pressed() -> void:
	GameManager.reset_progress()
	get_tree().change_scene_to_file(main_menu_scene_path)
