extends CharacterBody3D

class_name  Player

var can_move: bool = false

var axis: Vector2
var rot: Vector3
var angle: float
const SPEED: int = 12
const GRAVITY: int = 2
const JUMP: int = 30

var jump_count: int = 0
const MAX_JUMPS: int = 2

func _process(_delta):
	match can_move:
		true:
			motion_ctrl()

func _input(event):
	if event.is_action_pressed("ui_accept"):

		if is_on_floor():
			velocity.y = JUMP
			jump_count = 1

		elif jump_count < MAX_JUMPS:
			velocity.y = JUMP
			jump_count += 1

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()
	
func motion_ctrl() -> void:
	var input = get_axis()

	#MOVIMIENTO
	velocity.x = input.x * SPEED
	velocity.y -= GRAVITY
	velocity.z = input.y * -SPEED
	
	#ROTACIÓN
	if not input.x == 0 or not input.y == 0:
		angle = atan2(input.x, -input.y)
		rot = get_rotation()
		rot.y = angle
		set_rotation(rot)
		
	move_and_slide()
	
	#ANIMACIONES
	match is_on_floor():
		true:
			if not input.x == 0 or not input.y == 0:
				$AnimationPlayer.play("Run")
				$GPUParticles3D.emitting = true
			else:
				$AnimationPlayer.play("Idle")
				$GPUParticles3D.emitting = false
		false:
			if velocity.y > 0: 
				$AnimationPlayer.play("Jump")
				$GPUParticles3D.emitting = false

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Wave":
			can_move = true
