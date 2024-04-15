extends Panel

@onready var is_trap_label = %IsTrap
@onready var square_color_label = %SquareColor
@onready var square_coords_label = %SquareCoords
@onready var is_blocked_label = %IsBlocked


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var board = get_tree().root.get_node("DevBattle/%Board") as TileMap
	var board_square = board.world_to_board(board.get_global_mouse_position())
	var square_data = board.get_cell_tile_data(0, board_square) as TileData
	if !square_data:
		hide()
		return
	show()
	is_trap_label.text = "%s" % square_data.get_custom_data("is_trap")
	square_color_label.text = "%s" % square_data.get_custom_data("tile_color")
	square_coords_label.text = "%s" % board_square
	is_blocked_label.text  = "%s" % square_data.get_custom_data("is_blocked")
	pass
