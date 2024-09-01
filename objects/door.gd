extends StaticBody2D

@onready var door_audio: AudioStreamPlayer2D = $DoorAudio
@onready var particles: Node2D = $Particles
@onready var door_sprite: Sprite2D = $DoorSprite

@export var requirement: String = ''
var started: bool = false 

func _ready() -> void:
	particles.visible = false

func _on_door_detection_area_body_entered(body: CharacterBody2D) -> void:
	if body is not Player: return
	if started: return
	if HUD.get_keys() >= 3:
		started = true
		HUD.update_message("Door Unlocked!")
		particles.visible = true
		var tween = create_tween()
		tween.tween_property(door_sprite, "position", Vector2.RIGHT * 20, 1.6).as_relative().set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(door_sprite, "position", Vector2.LEFT * 20, 1.6).as_relative().set_trans(Tween.TRANS_LINEAR)
		tween.set_loops(2)
		#AUDIO
		await play_unlock_audio()
		door_audio.stream = preload("res://assets/sounds/slam.WAV")
		door_audio.play()
		await door_audio.finished
		queue_free()
	else:
		HUD.update_message(requirement)

func play_unlock_audio() -> void:
	door_audio.stream = preload("res://assets/sounds/lock1.WAV")
	door_audio.play(2.5)
	await door_audio.finished
	
	door_audio.play(2.5)
	await door_audio.finished
	
	door_audio.play(2.5)
	await door_audio.finished
