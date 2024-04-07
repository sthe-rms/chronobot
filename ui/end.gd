extends CanvasLayer

func _on_main_menu_button_pressed():
	GameManager.main_menu()
	queue_free()
