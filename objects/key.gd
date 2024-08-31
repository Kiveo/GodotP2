extends Area2D

@onready var key_animation: AnimationPlayer = %KeyAnimation

func _ready() -> void:
	key_animation.play("float")

func _on_body_entered(player: Player) -> void:
	if !player: return
	pickup()

func pickup() -> void:
	HUD.update_key_label(1)
	HUD.update_message("Found a key!")
	queue_free()
