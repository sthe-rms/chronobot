extends CanvasLayer

var settings_menu_screen = preload("res://ui/settings_menu_screen.tscn")
var CONTROLS_MENU_SCREEN = preload("res://ui/controls_menu_screen.tscn")

func _on_play_button_pressed():
	GameManager.start_game()
	queue_free()


func _on_exit_button_pressed():
	GameManager.exit_game()


func _on_settings_button_pressed():
	var settings_menu_screen_instance = settings_menu_screen.instantiate()
	get_tree().get_root().add_child(settings_menu_screen_instance)



func _on_controls_button_pressed():
	var controls_instance = CONTROLS_MENU_SCREEN.instantiate()
	get_tree().get_root().add_child(controls_instance)
