extends Control

onready var GSlide = $Panel/Gravity/GravSlider
onready var SSlide = $Panel/Speed/SpedSlider
onready var ASlide = $Panel/Acceleration/AcceSlider
onready var JSlide = $Panel/Jump/JumpSlider
onready var MSlide = $Panel/Sensitivity/SensSlider

onready var GLab = $Panel/Gravity/Gravlab
onready var SLab = $Panel/Speed/Spedlab
onready var ALab = $Panel/Acceleration/Accelab
onready var JLab = $Panel/Jump/Jumplab
onready var MLab = $Panel/Sensitivity/Senslab

onready var exit = $Panel/Exit
onready var reset = $Panel/Reset
onready var close = $Panel/Close

func _ready():
	var playerconfig = get_node("res://ScenesAndScripts/Player/playerconfig")
	hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") or close.is_pressed() == true == true: if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hide()
	elif Input.is_action_just_pressed("ui_cancel") and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		show()
	
	if reset.is_pressed() == true:
		get_tree().change_scene("res://Scenes/"+str("Debug World")+".tscn")
		
	if exit.is_pressed() == true:
		get_tree().quit()
		
		
	playerconfig.gravity = GSlide.value
	GLab.set_text(str(playerconfig.gravity))
	
	playerconfig.speed = SSlide.value
	SLab.set_text(str(playerconfig.speed))
	
	playerconfig.acceleration = ASlide.value
	ALab.set_text(str(playerconfig.acceleration))
	
	playerconfig.jump_power = JSlide.value
	JLab.set_text(str(playerconfig.jump_power))
	
	playerconfig.mouse_sensitivity = MSlide.value
	MLab.set_text(str(playerconfig.mouse_sensitivity))
	
#func _process(delta):
#	print(Player.speed)
