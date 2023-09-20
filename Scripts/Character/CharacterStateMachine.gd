extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : State

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			# Set the states up with what they need to function
			child.character = character
			
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine !")

func _physics_process(delta):
	if(current_state.next_state != null):
		switch_state(current_state.next_state)

func switch_state(new_state : State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	current_state.on_enter()

func can_move() -> bool:
	return current_state.can_move

func _input(event : InputEvent):
	current_state.state_input(event)
