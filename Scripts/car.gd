extends KinematicBody

#Declare member variables here
export var gravity = Vector3.DOWN * 50
export var speed = 65
export var rot_speed = 3.5

signal coinCollected

var velocity = Vector3.ZERO

func _physics_process(delta):
	velocity += gravity * delta
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)

func get_input(delta):
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("forward"):
		velocity += -transform.basis.x * speed
	if Input.is_action_pressed("back"):
		velocity += transform.basis.x * speed
	if Input.is_action_pressed("right"):
		rotate_y(-rot_speed * delta)
	if Input.is_action_pressed("left"):
		rotate_y(rot_speed * delta)
	velocity.y = vy


func _on_coin_coinCollected():
	print("coin collected")
	speed += 5
