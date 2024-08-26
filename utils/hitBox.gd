class_name HitBox
extends Area2D

@export var damage: int = 1
@export var friendly: bool = false

func _init() -> void:
	collision_mask = 0
	collision_layer = 0

func _ready() -> void:
	if friendly:
		set_collision_layer_value(4, true)
	else:
		set_collision_layer_value(5, true)
