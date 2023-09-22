extends Node

class_name Damageable

signal on_hit(node : Node, damage_taken : float, knockback : Vector2)

@export var health : float = 150.0 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func take_damage(damage : float, knockback : Vector2):
	health -= damage
	emit_signal("on_hit", get_parent(), damage, knockback)
