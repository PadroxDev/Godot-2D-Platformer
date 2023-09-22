extends State

class_name GroundedState

@export var jump_velocity : float = -150.0
@export var player : Player
@export var air_state : State
@export var draw_state : State
@export var sheathe_state : State
@export var attack_state : State

const JUMP_ANIMATION : String = "jump"
const MOVEMENT_BLEND_TREE : String = "movement"
const SWORD_MOVEMENT_BLEND_TREE : String = "sword_movement"
const SWORD_COMBO_ATTACK_0 : String = "sword_combo_0"

func state_process(_delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("draw_or_sheathe")):
		draw_or_sheathe()
	if(event.is_action_pressed("main_attack") && player.has_sword):
		combo_attack()

func on_enter():
	playback.travel(SWORD_MOVEMENT_BLEND_TREE if player.has_sword else MOVEMENT_BLEND_TREE)

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(JUMP_ANIMATION)

func draw_or_sheathe():
	player.has_sword = !player.has_sword
	next_state = draw_state if player.has_sword else sheathe_state
	
func combo_attack():
	next_state = attack_state
	playback.travel(SWORD_COMBO_ATTACK_0)
