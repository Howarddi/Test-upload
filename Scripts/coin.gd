extends Area

const COIN_ROT = 3
signal coinCollected
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	rotate_y(deg2rad(COIN_ROT))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()


func _on_coin_body_entered(body):
	if body.name == "car":
		$AnimationPlayer.play("coin_animation")
		emit_signal("coinCollected")
		$Timer.start()
		
