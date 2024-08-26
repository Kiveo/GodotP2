class_name HurtBox
extends Area2D

signal hurt(damage: int)

@export var friendly: bool = false

func _init() -> void:
	collision_layer = 0
	collision_mask = 0

func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	if friendly:
		set_collision_mask_value(5, true)
	else:
		set_collision_mask_value(4, true)

func _on_area_entered(hitbox: HitBox) -> void:
	if !hitbox: return 
	print("owner and attacker: ", owner, hitbox)
	hurt.emit(hitbox) # setup in Health script
