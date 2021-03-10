extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var speed = 200
var Bullet = preload("res://Scenes/Bullet.tscn")
var test = preload("res://Scenes/test.tscn")
var dir = get_global_mouse_position() - global_position


func shoot():
	var b = Bullet.instance()
	get_parent().add_child(b)
	b.start($Muzzle.global_position, rotation)
	
func _physics_process(delta):
	dir = get_global_mouse_position() - global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
