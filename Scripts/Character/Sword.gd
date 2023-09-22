extends Node

@export var combo_attack_0_damage : float = 25.0
@export var combo_attack_0_knockback : Vector2 = Vector2(30, 10)
@export var combo_attack_0_area : Area2D
@export var combo_attack_0_facing_shape : FacingCollisionShape2D

@export var combo_attack_1_damage : float = 30.0
@export var combo_attack_1_knockback : Vector2 = Vector2(30, 10)
@export var combo_attack_1_area : Area2D
@export var combo_attack_1_facing_shape_0 : FacingCollisionShape2D
@export var combo_attack_1_facing_shape_1 : FacingCollisionShape2D

@export var combo_attack_2_damage : float = 50.0
@export var combo_attack_2_knockback : Vector2 = Vector2(30, 10)
@export var combo_attack_2_area : Area2D
@export var combo_attack_2_facing_shape : FacingCollisionShape2D

@export var player : Player

func _ready():
	combo_attack_0_area.monitoring = false
	combo_attack_1_area.monitoring = false
	combo_attack_2_area.monitoring = false
	player.connect("facing_direction_changed", on_player_facing_direction_changed)
	
# Combo Attack 0
func _on_combo_attack_0_body_entered(body):
	damage_body(body, combo_attack_0_damage, combo_attack_0_knockback)

# Combo Attack 1
func _on_combo_attack_1_body_entered(body):
	damage_body(body, combo_attack_1_damage, combo_attack_1_knockback)
	
# Combo Attack 2
func _on_combo_attack_2_body_entered(body):
	damage_body(body, combo_attack_2_damage, combo_attack_2_knockback)

func on_player_facing_direction_changed(facing_right : bool):
	flip_collision_shape(combo_attack_0_facing_shape, facing_right)
	flip_collision_shape(combo_attack_1_facing_shape_0, facing_right)
	flip_collision_shape(combo_attack_1_facing_shape_1, facing_right)
	flip_collision_shape(combo_attack_2_facing_shape, facing_right)

func flip_collision_shape(facing_shape : FacingCollisionShape2D, facing_right : bool):
	facing_shape.position = facing_shape.facing_right_position if facing_right else facing_shape.facing_left_position

func damage_body(body, damage : float, knockback : Vector2):
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damageable = (body.global_position - get_parent().global_position).normalized()
			var direction_sign = sign(direction_to_damageable.x)
			
			var final_knockback = Vector2(knockback.x * direction_sign, knockback.y)
			child.take_damage(damage, final_knockback)
