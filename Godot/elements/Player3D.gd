extends KinematicBody
onready var animation_player = $CameraHolder/LinkAnimations

var direction = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var camera_tilt = Input.get_axis("rotate_right", "rotate_left")
	$CameraHolder.rotation_degrees.y += camera_tilt
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()
	var forward = -Vector3(-sin($CameraHolder.rotation.y), 0, -cos($CameraHolder.rotation.y))
	var right = Vector3(sin($CameraHolder.rotation.y + PI/2), 0, cos($CameraHolder.rotation.y + PI/2))
	var direction3d = direction.x*right + direction.y*forward
	print(direction3d)
	var coli = move_and_collide(direction3d * delta * 4)
	if direction3d.length()>0:
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
		
