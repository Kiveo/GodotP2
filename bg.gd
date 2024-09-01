extends CanvasLayer

@export var cloud_speed: float = 1.0
@onready var bg_animations: AnimationPlayer = $BGAnimations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bg_animations.speed_scale = cloud_speed
	bg_animations.play()
