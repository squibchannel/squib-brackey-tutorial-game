# res://ui/menus/menu_base.gd
class_name MenuBase
extends Control

signal menu_opened
signal menu_closed
signal back_requested

@export var first_focus: Control
@export var close_on_back := false

func _ready() -> void:
	# Useful for pause/death menus that may appear while the game is paused.
	process_mode = Node.PROCESS_MODE_ALWAYS

	if visible:
		call_deferred("focus_first")


func open_menu() -> void:
	visible = true
	set_process_unhandled_input(true)
	focus_first()
	menu_opened.emit()


func close_menu() -> void:
	visible = false
	set_process_unhandled_input(false)
	menu_closed.emit()


func focus_first() -> void:
	if is_instance_valid(first_focus):
		first_focus.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return

	if event.is_action_pressed("ui_cancel"):
		back_requested.emit()

		if close_on_back:
			close_menu()

		get_viewport().set_input_as_handled()
