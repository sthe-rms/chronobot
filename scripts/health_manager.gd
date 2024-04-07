extends Node

var max_health : int = 3
var current_health : int

signal on_health_change

func _ready():
	current_health = max_health
	update_health_ui()

func decrease_health(health_amount: int):
	current_health -= health_amount

	if current_health < 0:
		current_health = 0

	print("decrease_health called")
	update_health_ui()

func increase_health(health_amount: int):
	current_health += health_amount

	if current_health > max_health:
		current_health = max_health

	print("increase_health called")
	update_health_ui()

func update_health_ui():
	on_health_change.emit(current_health)
	
func death():
	current_health = max_health

