extends StaticBody2D

@onready var door_audio: AudioStreamPlayer2D = $DoorAudio

@export var requirement: String = ''

func _on_door_detection_area_body_entered(player: Player) -> void:
	if !player: return
	if HUD.get_keys() >= 3:
		HUD.update_message("Door Unlocked!")
		door_audio.play(2.5)
		queue_free()
	else:
		HUD.update_message(requirement)
