class_name Health extends Node

signal gained_health
signal lost_health
signal died

@export_range(1, 10, 1, "or_greater") var max_health: int
@export var health: int
@export var healthBar: ProgressBar

func _ready() -> void:
	if healthBar: 
		healthBar.value = health
		healthBar.max_value = max_health

## set_health replaces current with arg. 
## If arg == a negative value, sets health to max_health and emits gained_health
## If arg == 0, emit's died signal
func set_health(new_health: int) -> void:
	health = new_health
	if health >= max_health:
		health = max_health
	if health == 0:
		died.emit()
	if health < 0:
		health = max_health
		gained_health.emit()
	if healthBar: healthBar.value = health

## updates_health based on int value passed. 
## First param is the int to be added
## emits gained_health, lost_health, or died based on resultant health
func update_health(number: int) -> void:
	if (health + number) < health:
		lost_health.emit()
	elif (health + number) > health:
		gained_health.emit()
	# changes after initial checks
	health += number
	
	if health <= 0:
		died.emit()
	if healthBar: healthBar.value = health

func _on_hurt_box_hurt(hitbox: HitBox) -> void:
	update_health(-1 * hitbox.damage) # note manually set to negative
