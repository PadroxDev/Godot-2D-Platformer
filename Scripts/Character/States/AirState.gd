extends State

class_name AirState

@export var double_jump_velocity : float = -100.0
@export var grounded_state : State

const DOUBLE_JUMP_ANIMATION : String = "double_jump"
const FALL_ANIMATION : String = "fall"

var has_double_jumped : bool = false

func state_process(_delta):
	if(character.is_on_floor()):
		next_state = grounded_state
	else:
		update_fall_animation()

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()

func on_exit():
	if(next_state == grounded_state):
		has_double_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	has_double_jumped = true
	playback.travel(DOUBLE_JUMP_ANIMATION)

func update_fall_animation():
	if(character.velocity.y > 0):
		playback.travel(FALL_ANIMATION)
