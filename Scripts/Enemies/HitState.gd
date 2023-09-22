extends State

class_name HitState

@export var damageable : Damageable
@export var run_state : State # Will become patrol
@export var dead_state : State
@export var return_state : State

@onready var timer : Timer = $Timer

const HIT_ANIMATION : String = "hit"

func _ready():
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	timer.start()

func on_exit():
	character.velocity.x = 0

func on_damageable_hit(node : Node, damage : float, knockback : Vector2):
	if(damageable.health > 0):
		playback.travel(HIT_ANIMATION)
		character.velocity = knockback
		print(str(knockback) + " , " + str(character.velocity))
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)

func _on_timer_timeout():
	next_state = return_state
