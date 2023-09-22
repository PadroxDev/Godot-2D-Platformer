extends CharacterBody2D

class_name Player

@export var light_speed : float = 200.0
@export var carrying_speed : float = 180.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dirX : float = 0
var has_sword : bool = false

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta

	handle_movement(delta)

	move_and_slide()
	update_animation()
	update_facing_direction()

func handle_movement(_delta):
	dirX = Input.get_axis("move_left", "move_right")
	
	var speed = light_speed if !has_sword else carrying_speed
	if dirX != 0 && state_machine.can_move():
		velocity.x = dirX * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func update_animation():
	var path = "parameters/" + ("movement" if !has_sword else "sword_movement") + "/blend_position"
	animation_tree.set(path, dirX)

func update_facing_direction():
	if dirX == 0 || !state_machine.can_move(): return
	sprite.flip_h = dirX < 0
	emit_signal("facing_direction_changed", !sprite.flip_h)
