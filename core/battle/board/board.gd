extends TileMap
class_name ChessBoard

signal generation_complete

#region Board Parameters
@export_category("Board Parameters")
@export var board_width: int = 9
@export var board_height: int = 9

@export var block_chance = .2
@export var trap_chance = .05

#Random seed string to allow rememberable generations
@export var seed_string: String = ""

#endregion
#region Layer Parameters
@export_category("Layer Parameters")
@export var board_layer = 0
@export var obstacle_layer = 1
@export var highlight_layer = 2
#endregion
#region Board Visuals
@export_category("Tile Textures")
@export var black_tileset := 0
@export var white_tileset := 1
@export var highlight_tileset := 2
@export var trap_tileset := 3
@export var block_tileset:= 4
@export var black_tile_textures : Array[Vector2i] = [
	Vector2i.ZERO,
	Vector2i(2,0),
	Vector2i.ONE,
	Vector2i(3,1),
	Vector2i(0,2),
	Vector2i(2,2),
	Vector2i(1,3),
	Vector2i(3,3)
]
@export var white_tile_textures : Array[Vector2i] = [
	Vector2i.RIGHT,
	Vector2i(3,0),
	Vector2i.DOWN,
	Vector2i(2,1),
	Vector2i(1,2),
	Vector2i(3,2),
	Vector2i(0,3),
	Vector2i(2,3)
]
#endregion

# Called when the node enters the scene tree for the first time.
func _ready():
	#Hash our seed string and pass to rng seed, then perform initial randomization
	seed(seed_string.hash())
	randomize()
	BattleEvents.piece_move_request.connect(highlight_tiles)
	BattleEvents.piece_move_cancelled.connect(clear_highlights)
	BattleEvents.piece_moved.connect(clear_highlights)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func redraw():
	generate_board()

func generate_board():
	print("Generating board")
	clear()
	for x in board_width:
		for y in board_height:
			var cell = Vector2i(x,y)
			var cell_data = null
			if (x + y) % 2 == 0:
				var tileset = tile_set.get_source(black_tileset)
				var random_tile = tileset.get_tile_id(randi_range(0, tileset.get_tiles_count()-1))
				set_cell(board_layer, cell,black_tileset,random_tile,0)
				cell_data = get_cell_tile_data(board_layer, cell)
				cell_data.set_custom_data("is_blocked", false)
				cell_data.set_custom_data("is_trap", false)
				cell_data.set_custom_data("tile_color", "black")
				var rand_val = randf()
				if rand_val < block_chance:
					cell_data.set_custom_data("is_blocked", true)
					set_cell(obstacle_layer, cell, block_tileset, Vector2i.ZERO)
				rand_val = randf()
				if rand_val < trap_chance:
					cell_data.set_custom_data("is_trap", true)
					set_cell(obstacle_layer, cell, trap_tileset, Vector2i.ZERO)
			else:
				var tileset = tile_set.get_source(white_tileset)
				var random_tile = tileset.get_tile_id(randi_range(0, tileset.get_tiles_count()-1))
				set_cell(board_layer,cell,white_tileset,random_tile,0)
				cell_data = get_cell_tile_data(board_layer, cell)
				cell_data.set_custom_data("is_blocked", false)
				cell_data.set_custom_data("is_trap", false)
				cell_data.set_custom_data("tile_color", "white")
				var rand_val = randf()
				if rand_val < block_chance:
					cell_data.set_custom_data("is_blocked", true)
					set_cell(obstacle_layer, cell, block_tileset, Vector2i.ZERO)
				rand_val = randf()
				if rand_val < trap_chance:
					cell_data.set_custom_data("is_trap", true)
					set_cell(obstacle_layer, cell, trap_tileset, Vector2i.ZERO)
			if y >= board_height - 2:
				cell_data = get_cell_tile_data(0, cell)
				if cell_data.get_custom_data("is_blocked"):
					continue
				var starting_position = preload("res://core/battle/UI/starting_position.tscn").instantiate()
				starting_position.game_board = self
				var tile_position = board_to_world(cell)
				#starting_position.global_position = Vector2i(tile_position.x + tile_set.tile_size.x/2, tile_position.y - tile_set.tile_size.y/2)
				#starting_position.global_position = tile_position
				add_child(starting_position)
				center_reference_rect_on_tile(cell.x,cell.y,starting_position)
	generation_complete.emit()
	#await get_tree().create_timer(3).timeout
	##redraw()
	pass

func _unhandled_input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			#BattleEvents.piece_deselected.emit()
	pass

func world_to_board(local_pos: Vector2i):
	return local_to_map(to_local(local_pos))

func board_to_world(board_pos: Vector2i):
	return to_global(map_to_local(board_pos)) 

func is_square_blocked(square: Vector2i):
	var data: TileData = get_cell_tile_data(0, square)
	if !data:
		return null
	if data.get_custom_data("is_blocked"):
		return true
	if !data.get_custom_data("is_blocked"):
		return false
		
func is_square_trap(square: Vector2i):
	var data: TileData = get_cell_tile_data(0, square)
	if !data:
		return null
	if data.get_custom_data("is_trap"):
		return true
	if !data.get_custom_data("is_trap"):
		return false


func center_reference_rect_on_tile(tile_x, tile_y, reference_rect: ReferenceRect):
	# Get the size of the tiles (assuming square tiles for simplicity)
	var tile_size = tile_set.tile_size.x  # or .y if height could be different

	# Calculate the center of the tile in pixel coordinates
	var pixel_x = tile_x * tile_size + tile_size / 2
	var pixel_y = tile_y * tile_size + tile_size / 2

	# Adjust for the ReferenceRect's size to center it
	pixel_x -= reference_rect.size.x / 2
	pixel_y -= reference_rect.size.y / 2

	# Set the position of the ReferenceRect
	reference_rect.position = Vector2(pixel_x, pixel_y)

func highlight_tiles(tiles: Array[Vector2i]):
	clear_highlights()
	for tile_coords in tiles:
		var cell_data = get_cell_tile_data(board_layer,tile_coords)
		if !cell_data:
			continue
		set_cell(highlight_layer,tile_coords,highlight_tileset,Vector2i.ZERO)
		if !is_square_blocked(tile_coords):
			get_cell_tile_data(highlight_layer, tile_coords).modulate = Color.GREEN
		else:
			get_cell_tile_data(highlight_layer, tile_coords).modulate = Color.RED
	pass

func clear_highlights():
	clear_layer(highlight_layer)
