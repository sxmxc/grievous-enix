extends Camera2D

@export var min_zoom := 0.1
@export var max_zoom := 2
@export var zoom_factor := 0.1
@export var zoom_duration := 0.2
@export var focus_zoom_factor := .7
var zoom_level: float = .3
var prev_zoom_level: float = .3
var prev_position
var position_before_drag
var position_before_drag2

@onready var pcam: PhantomCamera2D = %PhantomBattleCamera2D


func _ready():
	BattleEvents.piece_selected.connect(_on_piece_selected)
	BattleEvents.piece_deselected.connect(_on_piece_deselected)
	pass

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		set_zoom_level(zoom_level + zoom_factor)
	elif event.is_action_pressed("zoom_out"):
		set_zoom_level(zoom_level - zoom_factor)
	elif event.is_action_pressed("camera_drag"):
		position_before_drag = event.global_position
		position_before_drag2 = self.global_position
	elif event.is_action_released("camera_drag"):
		position_before_drag = null
	elif event is InputEventPanGesture:
		self.global_position += event.delta * 20
	elif event is InputEventScreenDrag:
		self.global_position -= event.relative
	elif event is InputEventMagnifyGesture:
		if event.factor > 1:
			set_zoom_level(zoom_level + (zoom_factor * 0.5))
		elif event.factor < 1:
			set_zoom_level(zoom_level - (zoom_factor * 0.5))
	
	if position_before_drag and event is InputEventMouseMotion:
		self.global_position = position_before_drag2 + (position_before_drag - event.global_position) * (1/zoom_level)


func set_zoom_level(level: float, new_position = self.get_global_mouse_position()):
	pcam.set_zoom(Vector2(level, level))
	#var old_zoom_level = zoom_level
	#
	#zoom_level = clampf(level, min_zoom, max_zoom)
	#
#
	#var zoom_tween = get_tree().create_tween()
	#zoom_tween.tween_property(self,"zoom",Vector2(zoom_level, zoom_level), .5)
	#
	#if zoom_level == max_zoom || zoom_level == min_zoom:
		#return
	#
	#var pos_tween = get_tree().create_tween()
	#pos_tween.tween_property(self, "global_position", new_position, .5)


func _on_piece_selected(piece: ChessPiece):
	prev_zoom_level = zoom_level
	var board = %Board as ChessBoard
	set_zoom_level(focus_zoom_factor, board.board_to_world(board.world_to_board(piece.global_position)))
	pass

func _on_piece_deselected():
	set_zoom_level(prev_zoom_level)
	pass
