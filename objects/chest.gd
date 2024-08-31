extends Area2D

@onready var timer: Timer = $Timer
@onready var chest_animations: AnimationPlayer = %ChestAnimations

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is not Player: return
	HUD.update_message("Treasure Found!")
	chest_animations.play("open")
	await chest_animations.animation_finished
	timer.start()

func _on_timer_timeout() -> void:
	HUD.win()
