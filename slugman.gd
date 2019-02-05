extends Node2D
var speed = 60
var move_vector = Vector2(0, 0)
var orientation = "right"

func _ready():
	set_slugman_animation_chilling()
	pass
	
func _process(delta):
	position +=  speed * move_vector * delta
	
func set_slugman_animation_walking():
	$Sprite/AnimationPlayer.set_current_animation("walking")
	
func set_slugman_animation_talking():
	$Sprite/AnimationPlayer.play("talking")
	
func set_slugman_animation_chilling():
	$Sprite/AnimationPlayer.play("chilling")
	
func move_slugman(dir):
	set_slugman_animation_walking()
	if dir == "left":
		orientation = "left"
		move_vector.x = -1
	if dir == "right":
		orientation = "right"
		move_vector.x = 1
	if dir == "up":
		move_vector.y = -1
	if dir == "down":
		move_vector.y = 1
	update_orientation()

func stop_slugman():
	set_slugman_animation_chilling()
	move_vector = Vector2(0,0)
	
func update_orientation():
	if orientation == "left" && not $Sprite.flip_h:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
		
