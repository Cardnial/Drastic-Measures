extends KinematicBody

onready var playerconfig = get_node('../playerconfig')
var velocity = Vector3()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Cube = $KinematicBody

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var playerconfig = get_node('../playerconfig')
	
	var direction = Vector3()
	
	var cube_basis = Cube.get_global_transform().basis
	
	# This has something to do with movement i swear
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * playerconfig.speed, playerconfig.acceleration * delta)
	velocity.y -= playerconfig.gravity
	
	velocity = move_and_slide(velocity, Vector3.UP)
