extends Control

func _ready():
	hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hide()
	elif Input.is_action_just_pressed("ui_cancel") and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		show()
		
#func _process(delta):
#	print(Player.speed)


func _on_Button_pressed():
	get_tree().quit()
