extends Area2D

@onready var timer: Timer = $Timer
@onready var chest_animations: AnimationPlayer = %ChestAnimations
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is not Player: return
	HUD.update_message("Treasure Found!")
	audio_stream_player.play(3.5)
	await audio_stream_player.finished
	
	chest_animations.play("open")
	await chest_animations.animation_finished
	timer.start()

func _on_timer_timeout() -> void:
	HUD.win()
