class_name DamageEffects extends Node

var blinker_sprite: Sprite2D
var tween: Tween

func _set_shader_blink_intensity(newIntensity: float) -> void:
	if !blinker_sprite: 
		printerr("No blinker_sprite detected in _set_shader_blink_intensity")
		return
	blinker_sprite.material.set_shader_parameter("blink_intensity", newIntensity)

## Assumes presence of material "blink" shader and causes blink plus a knockback
## If passed a Vector2.Zero for damage_source_position, it will skip knockback
func blink_and_knockback(sprite: Sprite2D, originNode: Node2D, damage_source_position: Vector2) -> void:
	print("Sprite: ", sprite)
	if (!sprite || !sprite.material || !sprite.material): 
		printerr("No sprite or material detected in blink_and_knockback call. Sprite: ", sprite)
		return
	blinker_sprite = sprite
	
	if tween: tween.kill()
	tween = originNode.create_tween()
	tween.tween_method(_set_shader_blink_intensity, 1.0, 0.0, 0.5)
	if damage_source_position == Vector2.ZERO: return
	var away_position = -10 * (damage_source_position - originNode.position).clamp(Vector2i(-1, -1), Vector2i(1, 1))
	tween.parallel().tween_property(sprite, "position", away_position, 0.25).as_relative().from_current().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func() -> void: print("CALLBACK DONE FROM TWEEN CB"))
