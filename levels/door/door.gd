extends Node2D

@export var next_scene : String

@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var key_id : String

var door_open : bool


func _on_exit_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var player = body as CharacterBody2D
		player.queue_free()
	
	await get_tree().create_timer(1.0).timeout
	print("scene transition")
	SceneManager.transition_to_scene(next_scene)


func _on_activate_door_area_2d_body_entered(body):
	if body.is_in_group("player"):
		var has_item : bool = InventoryManager.has_inventory_item(key_id)
		
		if !has_item:
			return
		
		if !door_open:
			animated_sprite_2d.play("open")
			door_open = true
			collision_shape_2d.set_deferred("disabled", true)


func _on_activate_door_area_2d_body_exited(body):
	if body.is_in_group("player"):
		if door_open:
			animated_sprite_2d.play("close")
			door_open = false
