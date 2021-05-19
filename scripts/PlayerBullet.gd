extends Area2D

var velocity = Vector2()
var type
var effect = preload('res://scenes/ProjEffect.tscn')
export var speed = 500
export var damage = 10

func _ready():
	velocity = Vector2.UP.rotated(rotation) * speed


func _process(delta):
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()


func _on_PlayerBullet_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	var hit_effect = effect.instance()
	get_parent().add_child(hit_effect)
	hit_effect.play_hit_sound(type)
	self.queue_free()
	
