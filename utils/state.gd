class_name State extends Node

@export var animation_name: String
@export var move_speed: float = 600

var parent: CharacterBody2D

func enter() -> void:
	parent.animated_sprite_2d.play(animation_name)

func exit() -> void:
	pass

# state machine functions
func process_physics(_delta: float) -> State:
	return null
func process_update(_delta: float) -> State:
	return null
func process_input(_event: InputEvent) -> State:
	return null
