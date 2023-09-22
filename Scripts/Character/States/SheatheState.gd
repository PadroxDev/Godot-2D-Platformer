extends State

class_name SheatheState

@export var grounded_state : State

const SHEATHE_SWORD_ANIMATION : String = "sheathe_sword"

func on_enter():
	playback.travel(SHEATHE_SWORD_ANIMATION)

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == SHEATHE_SWORD_ANIMATION):
		next_state = grounded_state
