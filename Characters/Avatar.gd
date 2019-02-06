extends KinematicBody2D

const SPEED = 60
var movedir = Vector2(0, 0)
var target
var facedir = Vector2(-1, 0)
var can_move = true
var in_event = false

func _ready():
	$Camera2D.make_current()

func _physics_process(delta):
	controls_loop()
	movement_loop()

func controls_loop():
	if can_move:
		var LEFT = Input.is_action_pressed("ui_left")
		var RIGHT = Input.is_action_pressed("ui_right")
		var UP = Input.is_action_pressed("ui_up")
		var DOWN = Input.is_action_pressed("ui_down")
	
		movedir.x = -int(LEFT) + int(RIGHT)
		movedir.y = -int(UP) + int(DOWN)
		
	var INTERACT = Input.is_action_just_pressed("ui_accept")
	if INTERACT:
		interact(target)

func movement_loop():
	var motion = movedir.normalized() * SPEED
	if movedir.x > 0:
		$Sprite/AnimationPlayer.set_current_animation("run_side")
		$Sprite.flip_h = false
		facedir = movedir
	elif movedir.x < 0:
		$Sprite/AnimationPlayer.set_current_animation("run_side")
		$Sprite.flip_h = true
		facedir = movedir
	elif movedir.y > 0:
		$Sprite/AnimationPlayer.set_current_animation("run_down")
		facedir = movedir
	elif movedir.y < 0:
		$Sprite/AnimationPlayer.set_current_animation("run_back")
		facedir = movedir
	elif movedir.x == 0 and movedir.y == 0:
		$Sprite/AnimationPlayer.stop()
		if facedir.y > 0:
			$Sprite.frame = 0
		if facedir.y < 0:
			$Sprite.frame = 6
		if facedir.y == 0:
			$Sprite.frame = 3
	move_and_slide(motion, Vector2(0, 0))
	
func interact(e):
	if target:
		if in_event == false:
			print("You are interacting with " + target.name)
			can_move = false
			in_event = true
			target.do()
		else:
			target.trigger()
	else:
		print("No target to interact with!")
		in_event = false

func _on_area2D_body_enter(body, obj):
	if body.name == "Avatar":
		target = obj
		print("Target is " + target.name)

func _on_area2D_body_exit(body, obj):
	if body.name == "Avatar":
		target = null