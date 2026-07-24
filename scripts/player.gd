extends CharacterBody2D

var can_move = true

const MAX_SPEED = 400.0
const ACCELERATION = 1000.0
const FRICTION = 1200.0

func _physics_process(delta): 

	if !can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if direction != Vector2.ZERO: 
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()
	
