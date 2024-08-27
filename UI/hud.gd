extends CanvasLayer

@onready var key_h_box: HBoxContainer = $KeyHBox
@onready var key_label: Label = %KeyLabel
@onready var center_label: Label = %CenterLabel
@onready var start_button: Button = %StartButton
@onready var color_rect: ColorRect = %ColorRect
@onready var message_label: Label = %MessageLabel
@onready var message_timer: Timer = %MessageTimer

@export var data: HudData
var initial_center_text: String = ''

func _ready() -> void:
	if data:
		key_label.text = str(data.keys) + data.keyText
		update_key_label(0)
		update_center_label(data.centerText)
		initial_center_text = data.centerText
	key_h_box.visible = false
	get_tree().paused = true

func update_key_label(keys_to_add: int) -> void:
	if keys_to_add:
		data.keys += keys_to_add
		if data.keys >= 3: 
			data.keys = 3
	key_label.text = str(data.keys) + data.keyText

func update_center_label(new_text: String) -> void:
	if new_text:
		data.centerText = new_text
	center_label.text = data.centerText

func new_game() -> void:
	data.keys = 0
	data.centerText = initial_center_text
	update_center_label(data.centerText)
	update_key_label(0)
	start_button.disabled = false
	start_button.visible = true

func update_message(notice: String) -> void:
	message_label.text = notice
	message_label.visible = true
	message_timer.start()

func get_keys() -> int:
	return data.keys

func win() -> void:
	update_center_label("YOU WIN!")
	center_label.visible = true
	get_tree().paused = true

# REACTIONS / INTERNAL METHODS
func _on_start_button_pressed() -> void:
	new_game()
	#button manips after new_game to avoid re-activating
	start_button.disabled = true
	start_button.visible = false
	center_label.visible = false
	key_h_box.visible = true
	get_tree().paused = false

func _on_message_timer_timeout() -> void:
	message_label.visible = false
