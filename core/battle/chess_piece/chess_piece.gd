extends Node2D
class_name ChessPiece

@export var actor_data : ActorData

@onready var sprite = $Sprite2D
@onready var focus_indicator = $FocusIndicator

var dragging = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	focus_indicator.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:		
	pass


func _on_area_2d_mouse_entered():
	$StateMachine._on_mouse_entered()
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	$StateMachine._on_mouse_exited()
	pass # Replace with function body.
