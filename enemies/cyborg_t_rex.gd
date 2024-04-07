extends CharacterBody2D

var enemy_death_effect = preload("res://enemies/enemy_death_effect.tscn")
const FIREBALL = preload("res://enemies/fireball.tscn")

@export var speed := 80
var direction := -1
@export var damage_amount : int = 1


@onready var health_amount: int = 8
@onready var player_detector = $player_detector
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var fireball_spawn_point = $fireball_spawn_point
@onready var ground_detector = $ground_detector
@onready var sprite = $sprite
@onready var anim = $anim


enum EnemyState {PATROL, ATTACK}
var current_state = EnemyState.PATROL
var fireball_spawn_point_position

func _physics_process(delta : float):
	match(current_state):
		EnemyState.PATROL : patrol_state()
		EnemyState.ATTACK : attack_state()
	

func _on_hurt_box_area_entered(area: Area2D):
	print("hurtbox area entered")
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.damage_amount
		print("Health amount:", health_amount)
		
		if health_amount <= 0:
			var enemy_death_effect_instance = enemy_death_effect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position
			get_parent().add_child(enemy_death_effect_instance)
			queue_free()
			
func patrol_state():
	anim.play("running")
	if is_on_wall():
		flip_enemy()
		
	if !ground_detector.is_colliding():
		flip_enemy()
		
	velocity.x = speed * direction
	
	if player_detector.is_colliding():
		_change_state(EnemyState.ATTACK)

	move_and_slide()

	
func attack_state():
	anim.play("shooting")
	if !player_detector.is_colliding():
		_change_state(EnemyState.PATROL)
			
func _change_state(state):
	current_state = state
			
func spawn_fireball():
		var new_fireball = FIREBALL.instantiate()
		if sign(fireball_spawn_point.position.x) == -1:
			new_fireball.set_direction(-1)
		else:
			new_fireball.set_direction(1)
		add_sibling(new_fireball)
		new_fireball.global_position = fireball_spawn_point.global_position

func flip_enemy():
	direction *= -1
	sprite.scale.x *= -1
	player_detector.scale.x *= -1
	fireball_spawn_point.position.x *= -1
	


