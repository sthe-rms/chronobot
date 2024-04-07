extends CanvasLayer


func _on_play_button_pressed():
	GameManager.reiniciar_nivel()
	HealthManager.update_health_ui()
	queue_free()
	

func _on_exit_button_pressed():
	GameManager.exit_game()
