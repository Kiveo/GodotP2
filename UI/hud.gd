extends CanvasLayer

@onready var key_h_box: HBoxContainer = $KeyHBox
@onready var key_label: Label = %KeyLabel
@onready var center_label: Label = %CenterLabel
@onready var start_button: Button = %StartButton
@onready var color_rect: ColorRect = %ColorRect

@export var data: HudData
var initial_center_text: String = ''

func _ready() -> void:
	if data:
		key_label.text = str(data.keys) + data.keyText
		update_key_label()
		update_center_label(data.centerText)
		initial_center_text = data.centerText
	key_h_box.visible = false
	get_tree().paused = true

func add_keys() -> void:
	data.keys =+ 1
	if data.keys >= 3: 
		data.keys = 3
	update_key_label()

func update_key_label() -> void:
	key_label.text = str(data.keys) + data.keyText

func update_center_label(new_text: String) -> void:
	center_label.text = data.centerText

func new_game() -> void:
	data.keys = 0
	data.centerText = initial_center_text
	update_center_label(data.centerText)
	update_key_label()
	start_button.disabled = false
	start_button.visible = true

func _on_start_button_pressed() -> void:
	new_game()
	#button manips after new_game to avoid re-activating
	start_button.disabled = true
	start_button.visible = false
	center_label.visible = false
	key_h_box.visible = true
	get_tree().paused = false
	
	#color_rect.visible = false
