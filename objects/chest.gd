extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(player: Player) -> void:
	HUD.update_message("Treasure Found!")
	#TODO tween stuff
	timer.start()

func _on_timer_timeout() -> void:
	HUD.win()
