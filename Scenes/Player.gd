extends KinematicBody



# Refereces to the Head and Camera
onready var head = $Head
onready var camera = $Head/Camera
onready var ff3k = $fallfinder3000

onready var playerconfig = get_node('../playerconfig')

onready var jumpscout = 0
onready var speedmulti = 1

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
			head.rotate_y(deg2rad(-event.relative.x * playerconfig.mouse_sensitivity))
##			add code below for a haha haha funnie
##			camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
##			replace camera with head to add a noclip like mode
		
		# This Moves the Camera Up Down
		
		
			var x_delta = event.relative.y * playerconfig.mouse_sensitivity
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
	var playerconfig = get_node('../playerconfig')
	
	var head_basis = head.get_global_transform().basis
	
	if ff3k.is_colliding() == true: # and velocity.y < -9.99:
		jumpscout = 0
		velocity.y = 1
	#	playerconfig.health -= 1
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	#collision.collider.move_and_collide(velocity * delta)
	
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
	
	velocity = velocity.linear_interpolate(direction * (playerconfig.speed * speedmulti), playerconfig.acceleration * delta)
	velocity.y -= playerconfig.gravity
	
	if Input.is_action_pressed("sprint") and speedmulti < 3:
		speedmulti += 1
		jumpscout += 1
		
	elif speedmulti > 1:
		speedmulti -= 1
		
		
	if Input.is_action_just_pressed("jump") and jumpscout < 2:
		velocity.y += playerconfig.jump_power
		jumpscout += 1
		
	
		
	
	
	
	
