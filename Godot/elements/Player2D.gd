extends KinematicBody2D

var direction = Vector2()
onready var animation_player = $LinkAnimations

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()
	var coli = move_and_collide(direction)
	if direction.length()>0:
		print(coli)

func _process(delta):
	if direction.length() > 0:
		var animation = ""
		if abs(direction.x) > abs(direction.y):
			animation = "left" if direction.x < 0 else "right"
		else:
			animation = "up" if direction.y < 0 else "down"
		animation_player.play("walk_" + animation)
	else:
		animation_player.stop()
		
