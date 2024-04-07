extends Node2D

@export var heart1 : Texture2D
@export var heart0 : Texture2D

@onready var heart_1 = $Heart1
@onready var heart_2 = $Heart2
@onready var heart_3 = $Heart3

func _ready():
	HealthManager.on_health_change.connect(on_player_health_change)
	update_hearts(HealthManager.current_health)

func on_player_health_change(player_current_health: int):
	update_hearts(player_current_health)

func update_hearts(current_health: int):
	if current_health >= 1:
		heart_1.texture = heart1
	else:
		heart_1.texture = heart0

	if current_health >= 2:
		heart_2.texture = heart1
	else:
		heart_2.texture = heart0

	if current_health >= 3:
		heart_3.texture = heart1
	else:
		heart_3.texture = heart0

		

