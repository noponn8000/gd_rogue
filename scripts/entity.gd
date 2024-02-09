class_name Entity;
extends Sprite2D;

@export var pos := Vector2i.ZERO;
@export var map: Map;
@export var animate_movement := false;
@export var blocks_movement := true;

# Emitted when the entity moves.
# The first field is the entity, while the second one is the new position.
signal moved (Entity, Vector2i);

func _ready() -> void:
	if not map:
		map = get_parent();
		print(map);

func move(d_pos: Vector2i) -> void:
	var new_pos = pos + d_pos;

	if !map.is_cell_occupied(new_pos):
		pos = new_pos;
		moved.emit(self, pos);
