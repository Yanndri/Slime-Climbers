extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimationPlayer.play("IdleNPC")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		$AnimationPlayer.play("IdleNPC")


	move_and_slide()
	
func _on_detect_npc_area_entered(area):
	if area.is_in_group("slime"):
		velocity.y = JUMP_VELOCITY * 1.2
		$AnimationPlayer.play("JumpNPC")
