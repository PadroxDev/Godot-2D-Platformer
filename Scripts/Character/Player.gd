extends CharacterBody2D

@export var speed : float = 200.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dirX : float = 0
var has_double_jumped : bool = false

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false

	handle_jump()

	handle_movement(delta)

	move_and_slide()
	update_animation()
	update_facing_direction()

func handle_jump():
	if(Input.is_action_just_pressed("jump")):
		if(is_on_floor()):
			pass
		elif not has_double_jumped:
			pass
			#velocity.y = double_jump_velocity

func handle_movement(delta):
	dirX = Input.get_axis("move_left", "move_right")
	
	if dirX != 0 && state_machine.can_move():
		velocity.x = dirX * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func update_animation():
	animation_tree.set("parameters/Movement/blend_position", dirX)

func update_facing_direction():
	if dirX == 0: return
	sprite.flip_h = dirX < 0
