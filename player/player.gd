extends CharacterBody2D
class_name Player

var bullet = preload("res://player/bullet.tscn")
var player_death_effect = preload("res://player/player_death_effect/player_death_effect.tscn")
var GAME_OVER_MENU_SCREEN = preload("res://ui/gameOver_menu_screen.tscn")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var muzzle: Marker2D = $Muzzle
@onready var hit_animation_player = $HitAnimationPlayer

func player_death():
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	get_parent().add_child(player_death_effect_instance)
	queue_free()
	HealthManager.death()
	var game_over_instance = GAME_OVER_MENU_SCREEN.instantiate()
	get_tree().get_root().add_child(game_over_instance)
		
func _on_hurt_box_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		print ("Enemy entered", body.damage_amount)
		hit_animation_player.play("hit")
		HealthManager.decrease_health(body.damage_amount)
		
	if HealthManager.current_health == 0:
		player_death()
		
	if body.is_in_group("fireball"):
		body.queue_free()

func taking_damage():
	print ("Player colidiu")
	player_death()	
