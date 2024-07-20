extends CharacterBody2D
class_name  Grandma

enum States {IDLE = 0, WALKING, JUMPING, FALLING}


@export var GRAVITY:= 100.0
@export var MOVE_SPEED:= 200.0
@export var JUMP_SPEED:= 200.0
@export var MAX_JUMP_HEIGHT:= 200.0

var start_jump_height: float
var going_left:= false
var prev_state: int = 0
var current_state: int = 0

func _ready():
	collision_layer = Collision.GRANDMA
	collision_mask = Collision.FLOOR

func change_state(new_state: int):
	prev_state = current_state
	current_state = new_state

func apply_horizontal(delta: float):
	velocity.x = MOVE_SPEED
	velocity.x *= Input.get_axis("left", "right")

func apply_gravity(delta: float):
	if is_on_floor():
		pass
	velocity.y += GRAVITY * delta

func _input(event):
	if event.is_action_pressed("jump"):
		if current_state == States.JUMPING or current_state == States.FALLING:
			return
		start_jump_height = position.y
		velocity.y = -JUMP_SPEED
		change_state(States.JUMPING)
	if event.is_action_pressed("left"):
		going_left = true
		if current_state == States.IDLE:
			change_state(States.WALKING)
	if event.is_action_pressed("right"):
		going_left = false
		if current_state == States.IDLE:
			change_state(States.WALKING)
	if event.is_action_released("left") and going_left:
		if current_state == States.WALKING:
			change_state(States.IDLE)
	if event.is_action_released("right") and not going_left:
		if current_state == States.WALKING:
			change_state(States.IDLE)

func _physics_process(delta):
	apply_horizontal(delta)
	apply_gravity(delta)
	if current_state == States.JUMPING and velocity.y >= 0:
		change_state(States.FALLING)
	if current_state == States.FALLING and is_on_floor():
		if velocity.x == 0:
			change_state(States.IDLE)
		else:
			change_state(States.WALKING)
	move_and_slide()


