extends Node2D

@export var key_id : String


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		InventoryManager.add_to_inventory("key1", key_id)
		queue_free()
