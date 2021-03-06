extends KinematicBody

#Declare member variables here
export var gravity = Vector3.DOWN * 50
export var speed = 10
export var rot_speed = 3.5

var velocity = Vector3.ZERO

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()

	return xform
	
func _physics_process(delta):
	velocity += gravity * delta
	get_input(delta)
	#velocity = move_and_slide(velocity, Vector3.UP)
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN*2, Vector3.UP, true)
	#for i in get_slide_count():
		#var c = get_slide_collision(i)
		#global_transform = align_with_y(global_transform, c.normal)
	var n = $RayCast.get_collision_normal()
	var xform = align_with_y(global_transform, n)
	global_transform = global_transform.interpolate_with(xform, 0.2)

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
