class_name HudData extends Resource

@export var keys: int
@export var keyText: String
@export var centerText: String

func _init(n_keys: int = 0, n_keyText: String = '', n_centerText: String = '') -> void:
	keys = n_keys
	keyText = n_keyText
	centerText = n_centerText
