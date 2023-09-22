extends Control

@export var health_changed_label : PackedScene
@export var damage_color : Color = Color.DARK_RED
@export var heal_color : Color = Color.SEA_GREEN

func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)
	
func on_signal_health_changed(node : Node, amount_changed : float):
	var label_instance : Label = health_changed_label.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
	
	label_instance.modulate = damage_color if amount_changed < 0 else heal_color
