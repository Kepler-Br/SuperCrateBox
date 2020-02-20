extends Node2D

onready var root_node: = get_node("/root/Node2D/")
onready var spawn_areas: = get_children()
onready var player_data: = get_node("/root/Node2D/PlayerData/")
export (PackedScene) var crate
var new_crate: Crate

func _ready():
	randomize()
	new_crate = crate.instance()
	new_crate.name = "Crate"
	root_node.connect("ready", self, "_on_Node2D_ready")
	new_crate.connect("picked_up", self, "_on_crate_pickup")

func relocate_crate():
	var crate_spawner: = pick_spawn_area()
	var spawn_coordinates: = pick_spawn_place(crate_spawner)
	new_crate.position = spawn_coordinates

func pick_spawn_place(spawn_area: CrateSpawner) -> Vector2:
	spawn_area.spawn_width
	var local_x: = rand_range(-spawn_area.spawn_width/2.0, spawn_area.spawn_width/2.0)
	return Vector2(spawn_area.position.x + local_x, spawn_area.position.y)

func pick_spawn_area() -> CrateSpawner:
	var index: = randi()%len(spawn_areas)
	return spawn_areas[index]
		
func _on_Node2D_ready():
	get_node("/root/Node2D").add_child(new_crate)
	relocate_crate()

func _on_crate_pickup():
	player_data.score += 1
	relocate_crate()
