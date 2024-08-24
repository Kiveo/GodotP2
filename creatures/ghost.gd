extends CharacterBody2D

@onready var player: CharacterBody2D = %Player
@onready var sprite: Sprite2D = %Sprite2D
@onready var recovery_timer: Timer = %RecoveryTimer
@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D
@onready var detection_zone: Area2D = $DetectionZone
@onready var hurt_box: HurtBox = $HurtBox

const SPEED = 100.0
var origin: Vector2 = Vector2.ZERO
var alerted: bool = false
var health: int = 3
var recovering = false
var damage_effects: DamageEffects = DamageEffects.new()

# BUILT IN FUNCTIONS
func _ready() -> void:
	origin = global_position

func _physics_process(delta: float) -> void:
	if recovering: return
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
func _on_detection_zone_body_entered(body: Player) -> void:
	if !body: return
	alerted = true

func _on_detection_zone_body_exited(body: Player) -> void:
	if !body: return
	alerted = false

func _on_health_died() -> void:
	detection_zone.queue_free()
	hurt_box.queue_free()
	$Body.queue_free()
	damage_effects.fade_away(sprite)
	damage_effects.particle_explode(gpu_particles_2d)
	await get_tree().create_timer(gpu_particles_2d.lifetime).timeout
	queue_free()

## triggers effects other than health (which is handled by health component)
func _on_health_lost_health() -> void:
	recovering = true
	recovery_timer.start()
	damage_effects.blink_and_knockback(sprite, self, player.position)

func _on_recovery_timer_timeout() -> void:
	recovering = false
