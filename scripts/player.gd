extends CharacterBody2D

const MAX_SPEED = 400.0
const ACCELERATION = 1000.0
const FRICTION = 1200.0

func _physics_process(delta): 
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	print(direction)
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()
	print(global_position)
	print(velocity)
