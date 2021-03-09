extends Position2D

var target = Vector2()
var velocity = Vector2()
const SPEED = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func fire(at):
	print("am fired at ", at)
	target = at
	velocity = (target - position).normalized() * SPEED
	rotation = velocity.angle()

func _process(delta):
	position += velocity * delta;
	
	if position.distance_to(target) < 10:
		explode()
		return

func explode():
	print("killing self at ", position)
	queue_free()
