extends CanvasLayer
class_name Hud

@onready var timer_label: Label = %timer_label
@onready var coins: Label = %coins
@onready var lives: Label = %lives
@onready var bottles: Label = %bottles
@onready var stats_panel: PanelContainer = %StatsPanel


func _ready() -> void:
	GameManager.register_hud(self)


func _exit_tree() -> void:
	GameManager.unregister_hud(self)


func set_timer_text(value: String) -> void:
	timer_label.text = value
	
func set_total_lives(value: int) -> void:
	lives.text = "Lives: " + str(value)
	
func set_total_coins(value: int) -> void:
	coins.text = "Coins: " + str(value) + "/" + str(GameManager.coins_total)
	
func set_total_bottles(value: int) ->void:
	bottles.text = "Bottles: " + str(value) + "/" + str(GameManager.bottles_total)
