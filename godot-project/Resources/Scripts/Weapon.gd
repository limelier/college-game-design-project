extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var speed = 200
var Bullet = preload("res://Scenes/Bullet.tscn")
var test = preload("res://Scenes/test.tscn")


func shoot():
	var b = Bullet.instance()
	get_parent().add_child(b)
	b.start($Muzzle.global_position, rotation)
