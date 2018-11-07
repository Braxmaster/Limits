extends KinematicBody2D

const SPEED = 100
var movedir = Vector2(0, 0)
var target
var can_move = true
var in_event = false

func _ready():
	pass

func _physics_process(delta):
	controls_loop()
	if can_move:
		movement_loop()

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	var INTERACT = Input.is_action_just_pressed("ui_accept")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
	if INTERACT:
		interact(target)

func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0, 0))
	
func interact(e):
	pass

func _on_area2D_body_enter(body, obj):
	if body.name == "Player_kinematic":
		target = obj
		in_event = true

func _on_area2D_body_exit(body, obj):
	if body.name == "Player_kinematic":
		target = null
		in_event = false