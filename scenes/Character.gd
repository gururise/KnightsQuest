extends KinematicBody2D

export var GRAVITY = 200.0
export var WALK_SPEED = 200
export var JUMP_SPEED = 150
var velocity = Vector2()

# This function gets called 60x per second during physics updates
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	if Input.is_action_pressed("left") and $AnimatedSprite.animation != "attack":
		velocity.x = -WALK_SPEED
		if is_on_floor():
			$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right") and $AnimatedSprite.animation != "attack":
		velocity.x = WALK_SPEED
		if is_on_floor():
			$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = false
	else:
		velocity.x = 0
		if is_on_floor() and $AnimatedSprite.animation == "walk":
			$AnimatedSprite.animation = "idle"
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_SPEED
		$AnimatedSprite.animation = "jump"
	
	if Input.is_action_just_pressed("attack") and is_on_floor():
		$AnimatedSprite.animation = "attack"
		#$AudioStreamPlayer.play()
		$Timer.start(0.35)
	
	move_and_slide(velocity, Vector2.UP)

# Callback for animation end
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation != "walk":
		$AnimatedSprite.animation = "idle"

# Timer Callback for attack audio
func _on_Timer_timeout():
	$AudioStreamPlayer.play()
