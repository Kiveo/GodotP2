class_name Player
extends CharacterBody2D

@onready var recovery_timer: Timer = %RecoveryTimer
@onready var hurt_box: HurtBox = %HurtBox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_audio: AudioStreamPlayer = %PlayerAudio

var damage_effects: DamageEffects = DamageEffects.new()

const SPEED: float = 600.0
var recovering: bool = false

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	if Input.is_action_pressed("hold_player"):
		velocity = Vector2.ZERO
		return
	if velocity.x != 0 or velocity.y != 0:
		animated_sprite_2d.play("right")
		if sign(direction.x) != 0: animated_sprite_2d.flip_h = sign(direction.x) < 0.0
		#audio
		if !player_audio.playing: player_audio.play()
	else:
		animated_sprite_2d.stop()
		player_audio.playing = false
	move_and_slide()

func _on_hurt_box_hurt(hitbox: HitBox) -> void:
	print("HURT BOX TRIGGER FROM PLAYER")
	hurt_box.set_collision_mask_value(5, false)
	set_collision_layer_value(1, false)
	set_collision_mask_value(2, false)
	recovery_timer.start()
	damage_effects.blink_and_knockback(animated_sprite_2d, self, hitbox.global_position)
	recovering = true

func _on_recovery_timer_timeout() -> void:
	recovering = false
	hurt_box.set_collision_mask_value(5, true)
	set_collision_layer_value(1, true)
	set_collision_mask_value(2, true)
