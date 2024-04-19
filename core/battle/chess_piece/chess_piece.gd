extends Node2D
class_name ChessPiece

@export var actor_data : ActorData
@export var piece_color: Color = Color.WHITE

@onready var sprite = $Sprite2D
@onready var focus_indicator = $FocusIndicator
@onready var piece_menu = %PieceMenu


var dragging = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	focus_indicator.hide()
	piece_menu.hide()
	sprite.modulate = piece_color
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:		
	pass


func _on_area_2d_mouse_entered():
	$StateMachine._on_area_2d_mouse_entered()
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	$StateMachine._on_area_2d_mouse_exited()
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	$StateMachine._on_area_2d_input_event(viewport, event, shape_idx)
	pass # Replace with function body.
