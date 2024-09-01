extends CharacterBody2D

@onready var laser_timer: Timer = %LaserTimer
@onready var boss_animations: AnimationPlayer = %BossAnimations
@onready var laser: Sprite2D = %Laser
@onready var hit_box_collider: CollisionShape2D = %HitBoxCollider
@onready var player: Player = %Player
@onready var music: AudioStreamPlayer = $"../Music"
@onready var health_bar: ProgressBar = %HealthBar

var damage_effects: DamageEffects = DamageEffects.new()
const SPEED = 50.0
var alerted: bool = false
var attack_recharging: bool = false
var recovering: bool = false

func _ready() -> void:
	$BossBody.disabled = true
	hit_box_collider.disabled = true

func _physics_process(_delta: float) -> void:
	if !alerted or recovering:
		return
	var player_node = get_tree().get_nodes_in_group("player_target")[0]
	if !attack_recharging:
		laser.look_at(player_node.global_position)
		laser_attack()
		return
	if attack_recharging:
		if position.distance_to(player_node.global_position) >= 120:
			velocity = position.direction_to(player_node.global_position) * SPEED
		else:
			velocity = Vector2.ZERO
		move_and_slide()

func _on_boss_detection_area_body_entered(body: CharacterBody2D) -> void:
	if body is not Player: return
	alerted = true
	$BossBody.set_deferred("disabled", false)
	const PROJECT_COMBO__MASTERED___1_ = preload("res://assets/sounds/Project_combo (mastered) (1).wav")
	if music.stream == PROJECT_COMBO__MASTERED___1_:
		return
	music.stream = PROJECT_COMBO__MASTERED___1_
	music.play()

func laser_attack() -> void:
	attack_recharging = true
	laser_timer.start()
	boss_animations.play("attack")

func _on_laser_timer_timeout() -> void:
	attack_recharging = false

func _on_boss_detection_area_body_exited(body: CharacterBody2D) -> void:
	if body is not Player: return
	alerted = false
	$BossBody.set_deferred("disabled", true)

# HEALTH / HIT/ HURT
func _on_health_died() -> void:
	$BossDetectionArea.queue_free()
	$HurtBox.queue_free()
	$BossBody.queue_free()
	damage_effects.fade_away($BossSprite)
	damage_effects.particle_explode($GPUParticles2D)
	await get_tree().create_timer($GPUParticles2D.lifetime).timeout
	#if key_holder:
	const KEY = preload("res://objects/key.tscn")
	var new_key = KEY.instantiate()
	owner.add_child(new_key)
	new_key.global_position = self.global_position
	
	health_bar.visible = false
	await get_tree().create_timer(1.5).timeout
	const PROJECT_NIGHTV_4__1_ = preload("res://assets/sounds/Project nightv4 (1).mp3")
	music.stream = PROJECT_NIGHTV_4__1_
	music.play()
	queue_free()

func _on_health_lost_health() -> void:
	recovering = true
	$RecoveryTimer.start()
	damage_effects.blink_and_knockback($BossSprite, self, player.global_position)

func _on_recovery_timer_timeout() -> void:
	recovering = false
