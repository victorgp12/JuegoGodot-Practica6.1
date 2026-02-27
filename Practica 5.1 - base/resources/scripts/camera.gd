extends Camera3D

@export var player: CharacterBody3D

func _ready():
	position.y = 9

func _process(_delta):
	if player != null:
		position.x = player.position.x
		position.z = player.position.z + 10
