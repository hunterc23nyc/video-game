extends CharacterBody2D


@export var inv: Inv


const speed = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
		var direction = Input.get_vector("left", "right", "up", "down")
		
		velocity = direction * speed
		move_and_slide()


func player():
	pass
	
func collect(item):
	inv.insert(item)
