extends Node2D


var frame_switch_timer = 0
var viewport_initial_size = Vector2()

onready var viewport = $EnemyScreen
onready var viewport_sprite = $HUD/ViewportSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	# We want Godot to load everything but be hidden for a bit.
	viewport_sprite.modulate = Color(1, 1, 1, 0.01)
	#warning-ignore:return_value_discarded
	# get_viewport().connect("size_changed", self, "_root_viewport_size_changed")
	viewport_initial_size = viewport.size

	# Assign the sprite's texture to the viewport texture.
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)

	# Let two frames pass to make sure the screen was captured.
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	viewport_sprite.texture = viewport.get_texture()
	# Hide a little bit longer just in case.
	for _unused in range(50):
		yield(get_tree(), "idle_frame")
	viewport_sprite.modulate = Color.white # Default modulate color.# We want Godot to load everything but be hidden for a bit.
