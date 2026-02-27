extends  Path3D

@export var velocidad: int = 5

func _process(delta):
	$PathFollow3D.progress += velocidad * delta
