extends Label

var slime = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	text = " : " + str(slime)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = ":" + str(slime)

func _on_slime_spawn_slime():
	slime -= 1

func _on_slime_fruit():
	slime += 1
