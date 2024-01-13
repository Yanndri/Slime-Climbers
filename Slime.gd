extends CharacterBody2D


var SPEED = 150.0
const JUMP_VELOCITY = -350.0
signal spawn_slime
signal death
signal fruit
var double_jump = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var windowscale = ProjectSettings.get_setting("display/window/stretch/scale")
var slime = 1

func _ready():
	scale += Vector2(0.3, 0.3)
#	Engine.set_time_scale(0.5) // slow ingame time
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	# Add the gravity.
	if is_on_floor():
		$AnimationPlayer.play("Idle")

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("Jump")
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif not is_on_floor() and double_jump:
			velocity.y = JUMP_VELOCITY
			double_jump = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
#	if velocity.y < 0:
#		print(velocity.y)
#	else:
#		print(-velocity.y)
	move_and_slide()
	facing_direction_moving()
	drop_slime()
	voiddeath()
	
func facing_direction_moving():
	if velocity.x != 0:
		$AnimationPlayer.play("Move")
	if velocity.x > 0:
		$Sprite2D.flip_h = true
	elif velocity.x < 0:
		$Sprite2D.flip_h = false
		
func _on_feet_area_entered(area):
	if area.is_in_group("slime"):
		$AnimationPlayer.play("Jump")
#		velocity.y = JUMP_VELOCITY * 1.2
		velocity.y = JUMP_VELOCITY * 1.2
#		velocity.y = JUMP_VELOCITY * (velocity.y/350.0)
		print("slime")
		
func _on_consume_detect_body_entered(body):
	if body.is_in_group("slime"):
		body.queue_free()
		self.scale += Vector2(0.3, 0.3)
		emit_signal("fruit")
		slime += 1

func drop_slime():
	if Input.is_action_just_pressed("ui_down") && slime > 0:
		emit_signal("spawn_slime")
		position.y += -10 * (scale.y - 0.3)
		slime -= 1
		scale -= Vector2(0.3, 0.3)
		
func _on_trapdetect_area_entered(area):
	if area.is_in_group("traps"):
		self.queue_free()
	if area.is_in_group("apple"):
		double_jump = true
		
func voiddeath():
	if position.y > 650:
		emit_signal("death")
		position = Vector2(0, 400)
