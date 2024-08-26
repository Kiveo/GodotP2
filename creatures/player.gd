class_name Player
extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var recovery_timer: Timer = %RecoveryTimer
@onready var hurt_box: HurtBox = %HurtBox

var damage_effects: DamageEffects = DamageEffects.new()

const SPEED: float = 600.0
var recovering: bool = false

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	move_and_slide()

func _on_hurt_box_hurt(hitbox: HitBox) -> void:
	hurt_box.set_collision_mask_value(4, false)
	set_collision_layer_value(1, false)
	set_collision_mask_value(2, false)
	recovery_timer.start()
	damage_effects.blink_and_knockback(sprite, self, hitbox.global_position)
	recovering = true

func _on_recovery_timer_timeout() -> void:
	recovering = false
	hurt_box.set_collision_mask_value(4, true)
	set_collision_layer_value(1, true)
	set_collision_mask_value(2, true)
