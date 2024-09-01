extends CharacterBody2D

const KEY = preload("res://objects/key.tscn")

@onready var player: CharacterBody2D = %Player
@onready var sprite: Sprite2D = %Sprite2D
@onready var recovery_timer: Timer = %RecoveryTimer
@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D
@onready var detection_zone: Area2D = $DetectionZone
@onready var hurt_box: HurtBox = $HurtBox
@onready var health_bar: ProgressBar = %HealthBar
@onready var hit_box_ghost: HitBox = $HitBoxGhost

@export var key_holder: bool = false
@export var key_holder_style: StyleBoxFlat
const SPEED = 100.0
var origin: Vector2 = Vector2.ZERO
var alerted: bool = false
var health: int = 3
var recovering = false
var damage_effects: DamageEffects = DamageEffects.new()

# BUILT IN FUNCTIONS
func _ready() -> void:
	if key_holder and key_holder_style:
		health_bar.add_theme_stylebox_override("fill", key_holder_style)

func _physics_process(delta: float) -> void:
	if recovering: 
		%AnimationPlayer.stop()
		return
	if alerted:
		follow_player(delta)
	else:
		wander()

# CUSTOM FUNCTIONS
# Movement
func wander() -> void:
	%AnimationPlayer.play("wander")

func follow_player(delta: float) -> void:
	position += (player.position - position) * delta

# Logic / Helpers
# SIGNALS
func _on_detection_zone_body_entered(body: CharacterBody2D) -> void:
	if body is not Player: return
	alerted = true

func _on_detection_zone_body_exited(body: CharacterBody2D) -> void:
	if body is not Player: return
	alerted = false

func _on_health_died() -> void:
	detection_zone.queue_free()
	hurt_box.queue_free()
	hit_box_ghost.queue_free()
	$Body.queue_free()
	damage_effects.fade_away(sprite)
	damage_effects.particle_explode(gpu_particles_2d)
	await get_tree().create_timer(gpu_particles_2d.lifetime).timeout
	if key_holder:
		var new_key = KEY.instantiate()
		owner.add_child(new_key)
		new_key.global_position = self.global_position
	queue_free()

## triggers effects other than health (which is handled by health component)
func _on_health_lost_health() -> void:
	recovering = true
	recovery_timer.start()
	damage_effects.blink_and_knockback(sprite, self, player.global_position)

func _on_recovery_timer_timeout() -> void:
	recovering = false
