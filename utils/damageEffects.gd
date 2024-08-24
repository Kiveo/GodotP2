class_name DamageEffects extends Node

var prop_sprite: Sprite2D
var tween: Tween

func _set_shader_blink_intensity(newIntensity: float) -> void:
	if !prop_sprite: 
		printerr("No prop_sprite detected in _set_shader_blink_intensity")
		return
	prop_sprite.material.set_shader_parameter("blink_intensity", newIntensity)

func particle_explode(gpu_particles: GPUParticles2D) -> void:
	if !gpu_particles: return
	gpu_particles.restart()
	gpu_particles.emitting = true

func fade_away(sprite: Sprite2D) -> void:
	if !sprite: return
	if tween: tween.kill()
	var new_tween = sprite.create_tween()
	new_tween.tween_property(sprite, "modulate:a", 0, 0.25)

## Assumes presence of material "blink" shader and causes blink plus a knockback
## If passed a Vector2.Zero for damage_source_position, it will skip knockback
func blink_and_knockback(sprite: Sprite2D, originNode: Node2D, damage_source_position: Vector2) -> void:
	if (!sprite || !sprite.material || !sprite.material): 
		printerr("No sprite or material detected in blink_and_knockback call. Sprite: ", sprite)
		return
	prop_sprite = sprite
	
	if tween: tween.kill()
	tween = originNode.create_tween()
	tween.tween_method(_set_shader_blink_intensity, 1.0, 0.0, 0.5)
	if damage_source_position == Vector2.ZERO: return
	var away_position = -10 * (damage_source_position - originNode.position).sign()
	tween.parallel().tween_property(sprite, "position", away_position, 0.25).as_relative().from_current().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
