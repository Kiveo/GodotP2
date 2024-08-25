extends Node

# TODO can I avoid all the IF current_state checks with default state?
@export var starting_state: State
var current_state: State 

# assuming parent will pass self down during init/ready
func init(parent: CharacterBody2D) -> void:
	for child in get_children():
		child.parent = parent
	# default 
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

# NAMING CONVENTION IS NOT IDENTICAL TO _physics_process, to avoid constant disable toggling
# Passing functions for parent to call, changing state as needed
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_update(delta: float) -> void:
	var new_state = current_state.process_update(delta)
	if new_state:
		change_state(new_state)
