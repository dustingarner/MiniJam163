extends CharacterBody2D
class_name  Grandma

enum States {IDLE = 0, WALKING, JUMPING, FALLING}


@export var GRAVITY:= 10.0
@export var MOVE_SPEED:= 200.0
@export var JUMP_SPEED:= 100.0
@export var MAX_JUMP_HEIGHT:= 200.0

@onready var animation:= $AnimatedSprite2D
@onready var give_radius:= $GiveRadius

const ANIM_LOCATIONS:= {
	States.IDLE: -30,
	States.JUMPING: -31,
	States.FALLING: -31,
	States.WALKING: -28
}

var start_jump_height: float
var prev_state: int = 0
var current_state: int = 0

func _ready():
	collision_layer = Collision.GRANDMA
	collision_mask = Collision.FLOOR + Collision.OBSTACLE
	give_radius.collision_layer = Collision.GIVE_RADIUS
	give_radius.collision_mask = Collision.RECEIVE_RADIUS
	$TeleportIndicator.init(self)
	give_radius.area_entered.connect(func(area): area.toggle_reception(true))
	give_radius.area_exited.connect(func(area): area.toggle_reception(false))
	change_state(States.IDLE)

func change_state(new_state: int):
	prev_state = current_state
	current_state = new_state
	collision_mask = Collision.FLOOR + Collision.OBSTACLE
	animation.position.y = ANIM_LOCATIONS[new_state]
	if new_state == States.IDLE:
		animation.play("idle")
	if new_state == States.WALKING:
		animation.play("walking")
	if new_state == States.JUMPING:
		animation.play("jumping")
	if new_state == States.FALLING:
		collision_mask = Collision.FLOOR

func teleport(location: Vector2):
	var jump_offset: float
	if is_on_floor():
		jump_offset = 0
	else:
		jump_offset = abs(global_position.y - start_jump_height)
		start_jump_height = location.y
	global_position.x = location.x
	global_position.y = location.y - jump_offset

func apply_horizontal(delta: float):
	velocity.x = MOVE_SPEED
	var axis:= Input.get_axis("left", "right")
	velocity.x *= axis

func apply_gravity(delta: float):
	if is_on_floor():
		pass
	velocity.y += GRAVITY * delta

func _input(event):
	if event.is_action_pressed("jump"):
		if current_state == States.JUMPING or current_state == States.FALLING:
			return
		start_jump_height = global_position.y
		velocity.y = -JUMP_SPEED
		change_state(States.JUMPING)
	if event.is_action_pressed("left"):
		animation.scale.x = abs(animation.scale.x) * -1
		if current_state == States.IDLE:
			change_state(States.WALKING)
	if event.is_action_pressed("right"):
		animation.scale.x = abs(animation.scale.x)
		if current_state == States.IDLE:
			change_state(States.WALKING)
	if (event.is_action_released("left") or event.is_action_released("right")) and \
			current_state == States.WALKING:
		if Input.get_axis("left", "right") == 0:
			change_state(States.IDLE)

func _physics_process(delta):
	apply_horizontal(delta)
	apply_gravity(delta)
	if (current_state == States.IDLE or current_state == States.WALKING) and \
			not is_on_floor():
		change_state(States.FALLING)
	if current_state == States.JUMPING and velocity.y >= 0:
		change_state(States.FALLING)
	if current_state == States.FALLING and is_on_floor():
		if velocity.x == 0:
			change_state(States.IDLE)
		else:
			change_state(States.WALKING)
	move_and_slide()


