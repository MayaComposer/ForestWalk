extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -600.0

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 1


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("jump") and not is_on_floor():
		if velocity.y < 100:
			velocity.y = -100

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
func _process(delta):
	if direction == 1 and velocity.x > 0:
		anim.play("walk")
		sprite.flip_h = false
	elif direction == -1 and velocity.x < 0:
		anim.play("walk")
		sprite.flip_h = true
	else:
		anim.play("idle")
