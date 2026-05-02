# res://ui/menus/start_menu.gd
extends MenuBase

@export_file("*.tscn") var first_level_scene := "res://scenes/game.tscn"

@onready var start_button: Button = %StartButton
#@onready var options_button: OptionButton = %OptionsButton
@onready var exit_button: Button = %ExitButton

#var selected_option := "Normal"


func _ready() -> void:
	super._ready()

	first_focus = start_button

	#_setup_options()

	start_button.pressed.connect(_on_start_pressed)
	#options_button.item_selected.connect(_on_option_selected)
	exit_button.pressed.connect(_on_exit_pressed)

	focus_first()


#func _setup_options() -> void:
	#options_button.clear()
#
	#options_button.add_item("General")
	#options_button.add_item("Graphics")
	#options_button.add_item("Audio")
#
	#options_button.select(1)
	#selected_option = options_button.get_item_text(1)


func _on_start_pressed() -> void:
	GameManager.start_new_run()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


#func _on_option_selected(index: int) -> void:
	#selected_option = options_button.get_item_text(index)
	#print("Selected option: ", selected_option)


func _on_exit_pressed() -> void:
	get_tree().quit()
