extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("apple")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	$Area2D.set_deferred("monitorable", false)
	$Area2D.set_deferred("monitoring", false)
	self.hide()
	$Timer.start(3)
	

func _on_timer_timeout():
	print("meow")
	$Area2D.set_deferred("monitorable", true)
	$Area2D.set_deferred("monitoring", true)
	self.show()
	
