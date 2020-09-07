extends Control

onready var playerconfig = get_node('../playerconfig')
onready var hp = $Health

func _process(delta):
	hp.set_text(str(playerconfig.health))
