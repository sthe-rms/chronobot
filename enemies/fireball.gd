extends CharacterBody2D

@export var damage_amount : int = 1
@onready var health_amount: int = 1
@onready var anim = $anim

var move_speed := 250
var direction := 1

func _process(delta):
	position.x += move_speed * direction * delta
	
func set_direction(dir):
	direction = dir
	if dir < 0:
		$anim.flip_h = true
	else:
		$anim.flip_h = false

