extends State

const DEATH_ANIMATION_NAME : String = "death"

func on_enter():
	playback.travel(DEATH_ANIMATION_NAME)

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == DEATH_ANIMATION_NAME):
		get_parent().get_parent().queue_free()
