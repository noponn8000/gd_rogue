extends Entity
class_name Player;

func _ready() -> void:
	super._ready();

	animate_movement = true;

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
