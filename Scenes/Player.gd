extends KinematicBody

# Settings Would Probably Change These Lines
export var speed = 10
export var acceleration = 5
export var gravity = 1
export var jump_power = 30
export var mouse_sensitivity = 0.3
export var camera_fov = 90

# Refereces to the Head and Camera
onready var head = $Head
onready var camera = $Head/Camera

# Witchcraft
var velocity = Vector3()

# Centers Camera
var camera_x_rotation = 0
var camera_y_rotation = 0

# Captures Cursor
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Move the Camera Around
func _input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
##			add code below for a haha haha funnie
##			camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
##			replace camera with head to add a noclip like mode
		
		# This Moves the Camera Up Down
		
		
			var x_delta = event.relative.y * mouse_sensitivity
			# This Makes it So You Have a Spine
			if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
				camera.rotate_x(deg2rad(-x_delta))
				camera_x_rotation += x_delta
		
# Press Esc to Toggle Cursor Lock
#func _process(delta):
#	if Input.is_action_just_pressed("ui_cancel") and Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
#		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	elif Input.is_action_just_pressed("ui_cancel") and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
# feature moved to Debug Menu

# WASD	
func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	
	# This has something to do with movement i swear
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	velocity = move_and_slide(velocity, Vector3.UP)
