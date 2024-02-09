class_name Map;
extends TileMap

@export var bounds_x := Vector2i(-20, 20);
@export var bounds_y := Vector2i(-20, 20);

var entities: Array[Entity] = [];

func add_entity(e: Entity) -> void:
	if e not in entities:
		entities.append(e);
	else:
		print("Failure to add entity: duplicate entity exists in dictionary.");

func update_entity_positions(skip_animations: bool = false) -> void:
	for e in entities:
		if !skip_animations and e.animate_movement:
			var tween := get_tree().create_tween();
			tween.tween_property(e, "position", map_to_local(e.pos), 0.25).set_trans(Tween.TRANS_CUBIC);
		else:
			e.position = map_to_local(e.pos);
		
func snap_entity_to_grid(e: Entity) -> void:
	e.pos = local_to_map(e.position);
	
func print_entities_debug() -> void:
	print("Entities (" + str(len(entities)) + "):");
	for entity in entities:
		print(str(entity.pos) + ": " + entity.name);

func is_in_bounds(pos: Vector2i) -> bool:
	return pos.x >= bounds_x.x and pos.x <= bounds_x.x and pos.y >= bounds_y.y and pos.y <= bounds_y.y;

func is_tilemap_cell_occupied(pos: Vector2i) -> bool:
	return get_cell_atlas_coords(1, pos) != Vector2i(-1, -1); 

func is_cell_occupied(pos: Vector2i) -> bool:
	var e := get_top_entity_at_position(pos);
	return e != null and e.blocks_movement;

func get_entities_at_position(pos: Vector2i) -> Array[Entity]:
	var arr: Array[Entity] = [];

	for e in entities:
		if e.pos == pos:
			arr.append(e);

	return arr;
	
func get_top_entity_at_position(pos: Vector2i) -> Entity:
	var arr := get_entities_at_position(pos);
	if arr != []:
		arr.sort_custom(func(e1, e2): return e1.z_index > e2.z_index);
		return arr[0];
	else:
		return null;

func step() -> void:
	update_entity_positions();

func _ready() -> void:
	for child in get_children():
		if child is Entity:
			snap_entity_to_grid(child);
			add_entity(child);
			child.moved.connect(on_entity_moved);

	print_entities_debug();
	update_entity_positions(true);

func on_entity_moved(e: Entity, pos: Vector2i) -> void:
	if e is Player:
		step();
