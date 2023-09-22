extends State

class_name DrawState

@export var grounded_state : State

const DRAW_SWORD_ANIMATION : String = "draw_sword"

func on_enter():
	playback.travel(DRAW_SWORD_ANIMATION)
	
func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == DRAW_SWORD_ANIMATION):
		next_state = grounded_state
