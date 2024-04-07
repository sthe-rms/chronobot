extends CharacterBody2D

var enemy_death_effect = preload("res://enemies/enemy_death_effect.tscn")
const KNIVE = preload("res://enemies/knive.tscn")

@export var damage_amount : int = 2
@onready var health_amount: int = 3
@onready var player_detector = $player_detector
@onready var knive_spawn_point = $knive_spawn_point
@onready var anim = $anim

enum EnemyState {PATROL, ATTACK}
var current_state = EnemyState.PATROL
var fireball_spawn_point_position


func _physics_process(delta):
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
			
func spawn_knive():
		var new_knive = KNIVE.instantiate()
		if sign(knive_spawn_point.position.x) == 1:
			new_knive.set_direction(1)
		else:
			new_knive.set_direction(-1)
		add_sibling(new_knive)
		new_knive.global_position = knive_spawn_point.global_position

func patrol_state():
	anim.play("idle")
	if player_detector.is_colliding():
		_change_state(EnemyState.ATTACK)

	move_and_slide()
	
func attack_state():
	anim.play("shooting")
	if !player_detector.is_colliding():
		_change_state(EnemyState.PATROL)
		
func _change_state(state):
	current_state = state
	
