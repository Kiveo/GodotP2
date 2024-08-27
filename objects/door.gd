extends StaticBody2D

@export var requirement: String = ''
@onready var ray_cast_2d: RayCast2D = %RayCast2D
@onready var timer: Timer = %Timer

func _physics_process(_delta: float) -> void:
	if ray_cast_2d.is_colliding():
		if HUD.get_keys() >= 3:
			HUD.update_message("Door Unlocked!")
			queue_free()
		else:
			HUD.update_message(requirement)
