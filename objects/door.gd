extends StaticBody2D

@export var required_keys: int = 1
@onready var ray_cast_2d: RayCast2D = %RayCast2D

func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		print("COLLISION detected")
