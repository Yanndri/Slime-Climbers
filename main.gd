extends Node2D

var slime_scene = preload("res://slimeNPC.tscn")
var level1 = preload("res://level_1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(level1.instantiate())

func _on_slime_spawn_slime():
	var slime_instance = slime_scene.instantiate()
	add_child(slime_instance)
	slime_instance.position = $Slime.position
#	slime_instance.scale = $Slime.scale - Vector2(0.3, 0.3)
#	slime_instance.position = Vector2()

func _on_slime_death():
	pass # Replace with function body.
