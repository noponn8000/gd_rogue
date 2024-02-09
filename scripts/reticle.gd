extends Entity
class_name Reticle;

func move(d_pos: Vector2i) -> void:
	var new_pos = pos + d_pos;

	if map.is_in_bounds(new_pos):
		pos += d_pos;

func _input(event: InputEvent) -> void:
	var dir := Vector2i.ZERO;
	
	if Input.is_action_just_pressed("ui_left"):
		dir.x = -1;
	elif Input.is_action_just_pressed("ui_right"):
		dir.x = 1;
	elif Input.is_action_just_pressed("ui_up"):
		dir.y = -1;
	elif Input.is_action_just_pressed("ui_down"):
		dir.y = 1;

	if dir != Vector2i.ZERO:
		move(dir);
