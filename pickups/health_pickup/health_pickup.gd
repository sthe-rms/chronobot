extends Node2D

@export var pickup_amount : int = 1

func _on_health_pickup_area_2d_body_entered(body):
	if body.is_in_group("player"):
		HealthManager.increase_health(pickup_amount)
		queue_free()
