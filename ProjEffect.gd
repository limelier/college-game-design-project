extends Node2D

var sounds = {
	'starter': preload("res://resources/sounds/projectile-hit.wav"),
	'shotgun': preload("res://resources/sounds/projectile-hit.wav"),
	'rocket': preload("res://resources/sounds/projectile-hit.wav"),
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func clear_sounds(node):
	node.queue_free()
	queue_free()
	
func play_hit_sound(type):
	
	var sound_player = AudioStreamPlayer.new()
	add_child(sound_player)
	if type == 'starter':
		sound_player.stream = sounds['starter']
	elif type == 'pellet':
		sound_player.stream = sounds['shotgun']
	elif type == 'rocket':
		sound_player.stream = sounds['rocket']
	sound_player.play()
	sound_player.connect('finished', self, 'clear_sounds', [sound_player])
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
