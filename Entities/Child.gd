extends CharacterBody2D
class_name Child

enum States {IDLE = 0, WALKING, RUNNING, FOOD_COMA}

signal start_coma

@export var WALK_SPEED:= 500
@export var RUN_SPEED:= 800

@export var child_id:= 0

@onready var animation:= $AnimatedSprite2D
@onready var teleporter_indicator:= $TeleportIndicator
@onready var receive_radius:= $ReceiveRadius
@onready var turn_around_indicator:= $TurnAroundIndicator

var can_receive:= false
var can_click:= false
var can_stop:= true
var wait_timer:= 0.0
var max_wait:= 500.0
var move_direction:= -1
var prev_state: int = 0
var current_state: int = 0
var move_adjustment: float
var number_cookies:= 0

func _ready():
	assert(child_id != 0 and child_id < 4, "child_id must be set to 1, 2, or 3.")
	collision_layer = Collision.CHILDREN
	collision_mask = Collision.FLOOR
	receive_radius.collision_layer = Collision.RECEIVE_RADIUS
	receive_radius.collision_mask = Collision.NONE
	teleporter_indicator.init(self)
	turn_around_indicator.collision_mask = Collision.TURN_AROUND
	teleporter_indicator.area_entered.connect(func(area): can_stop = false)
	teleporter_indicator.area_exited.connect(func(area): can_stop = true)
	receive_radius.mouse_entered.connect(func(): toggle_clickable(true))
	receive_radius.mouse_exited.connect(func(): toggle_clickable(false))
	receive_radius.send_toggle.connect(toggle_reception)
	turn_around_indicator.area_entered.connect(func(area): 
			move_direction *= -1
			animation.scale.x *= -1)
	start_idle()

func change_state(new_state: int):
	prev_state = current_state
	current_state = new_state
	if new_state == States.IDLE:
		animation.play("idle%d" % child_id)
	elif new_state == States.FOOD_COMA:
		animation.play("coma%d" % child_id)
	else:
		animation.play("run%d" % child_id)

func start_idle():
	randomize()
	wait_timer = 0.0
	max_wait = randf() + 0.5
	change_state(States.IDLE)

func toggle_reception(toggle: bool): can_receive = toggle

func toggle_clickable(toggle: bool): can_click = toggle

func teleport(location: Vector2): global_position = location

func receive_cookie():
	if current_state == States.RUNNING or current_state == States.FOOD_COMA:
		return
	GameAudio.play_crunch()
	can_click = false
	can_receive = false
	start_moving(States.RUNNING)
	number_cookies += 1
	if number_cookies > 3:
		change_state(States.FOOD_COMA)
		start_coma.emit()

func start_moving(new_state: int):
	randomize()
	move_direction = -1 if randf() < 0.5 else 1
	wait_timer = 0.0
	max_wait = randf() + 1.5
	animation.scale.x = -abs(animation.scale.x) * move_direction
	move_adjustment = 0.85 + (randf() * 0.3)
	change_state(new_state)

func apply_horizontal(delta):
	var speed: int
	if current_state == States.IDLE:
		speed = 0
	if current_state == States.WALKING:
		speed = WALK_SPEED * move_adjustment
	if current_state == States.RUNNING:
		speed = RUN_SPEED * move_adjustment
	velocity.x = speed * move_direction

func _input(event):
	if not event is InputEventMouseButton:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	if not can_receive or not can_click:
		return
	receive_cookie()

func _physics_process(delta):
	if current_state == States.FOOD_COMA:
		return
	apply_horizontal(delta)
	if current_state == States.IDLE:
		wait_timer += delta
		if wait_timer >= max_wait:
			start_moving(States.WALKING)
	if current_state == States.WALKING:
		wait_timer += delta
		if wait_timer >= max_wait:
			start_idle()
	if current_state == States.RUNNING:
		wait_timer += delta
		if wait_timer >= max_wait:
			start_idle()
	if not is_on_floor():
		velocity.y = 800
	move_and_slide()


