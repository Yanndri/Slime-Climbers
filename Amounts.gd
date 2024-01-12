extends Label

var slime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "slime: " + str(slime)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "slime:" + str(slime)


func _on_consume_detect_body_entered(body):
	if body.is_in_group("slime"):
		slime += 1

func _on_slime_spawn_slime():
	slime -= 1
