extends CharacterBody2D

@onready var player: CharacterBody2D = %Player
@onready var sprite: Sprite2D = %Sprite2D
@onready var recovery_timer: Timer = %RecoveryTimer

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
	velocity = Vector2(randf_range(-50.0, 50.0),randf_range(-20.0, 20.0))
	move_and_slide()

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
	queue_free()

# TODO REMOVE ONCE FUNCTIONAL REPLACEMENT CONFIRM
#func setShader_BlinkIntensity(newIntensity: float) -> void:
	#sprite.material.set_shader_parameter("blink_intensity", newIntensity)
## triggers effects other than health (which is handled by health component)
func _on_health_lost_health() -> void:
	recovering = true
	recovery_timer.start()
# TODO REMOVE ONCE FUNCTIONAL REPLACEMENT CONFIRM
	#var damageEffects = DamageEffects.new()
	damage_effects.blink_and_knockback(sprite, self, player.position)
	
	#var tween = create_tween()
	#tween.tween_method(setShader_BlinkIntensity, 1.0, 0.0, 0.5)
	#var away_position = -10 * (player.position - position).clamp(Vector2i(-1, -1), Vector2i(1, 1))
	#tween.parallel().tween_property(sprite, "position", away_position, 0.25).as_relative().from_current().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

func _on_recovery_timer_timeout() -> void:
	recovering = false
