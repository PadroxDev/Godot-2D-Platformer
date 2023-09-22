extends State

class_name AttackState

@export var grounded_state : State

@onready var timer : Timer = $Timer

const SWORD_COMBO_0 = "sword_combo_0"
const SWORD_COMBO_1 = "sword_combo_1"
const SWORD_COMBO_2 = "sword_combo_2"

func state_input(event : InputEvent):
	if(event.is_action_pressed("main_attack")):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == SWORD_COMBO_0):
		if(timer.is_stopped()):
			next_state = grounded_state
		else:
			playback.travel(SWORD_COMBO_1)

	if(anim_name == SWORD_COMBO_1):
		if(timer.is_stopped()):
			next_state = grounded_state
		else:
			playback.travel(SWORD_COMBO_2)
			
	if(anim_name == SWORD_COMBO_2):
		next_state = grounded_state
