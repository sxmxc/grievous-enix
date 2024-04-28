extends Node2D
class_name ChessPiece

@export var actor_data : ActorData
@export var piece_color: Color = Color.WHITE

@onready var sprite = $Sprite2D
@onready var focus_indicator = $FocusIndicator
@onready var piece_menu = %PieceMenu
@onready var state_machine = $PieceStateMachine


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
	state_machine._on_area_2d_mouse_entered()
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	state_machine._on_area_2d_mouse_exited()
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	state_machine._on_area_2d_input_event(viewport, event, shape_idx)
	pass # Replace with function body.


func _on_move_button_pressed():
	var available_moves = actor_data.get_moves(BattleManager.current_board.world_to_board(position))
	BattleEvents.piece_move_request.emit(available_moves)
	pass # Replace with function body.


func _on_cancel_button_pressed():
	piece_menu.hide()
	BattleEvents.piece_deselected.emit()
	BattleEvents.piece_move_cancelled.emit()
	state_machine.transition_to("OnBoard")
	pass # Replace with function body.


func _on_ability_button_pressed():
	var abilities: Array[AbilitySkill] = []
	for skill in actor_data.actor_known_skills:
		if skill is AbilitySkill:
			abilities.append(skill)
	piece_menu.populate_ability_menu(abilities)
	piece_menu.get_node("%Main").hide()
	piece_menu.get_node("%Abilities").show()
	pass # Replace with function body.
