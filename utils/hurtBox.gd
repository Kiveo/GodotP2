class_name HurtBox
extends Area2D

signal hurt(damage: int)

func _init() -> void:
	collision_layer = 0
	collision_mask = 4

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if !hitbox: return 
	
	hurt.emit(hitbox.damage) # setup in Health script
