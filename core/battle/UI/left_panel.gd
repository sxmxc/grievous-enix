extends Panel

@onready var actor_details = %ActorDetails
@onready var player_roster = %PlayerRoster
@onready var profile_image = %ProfileImage
@onready var class_level = %ClassLevel
@onready var chess_class = %ChessClass
@onready var actor_name =  %ActorName

var selected_piece : ChessPiece = null 


# Called when the node enters the scene tree for the first time.
func _ready():
	BattleEvents.piece_selected.connect(_on_piece_selected)
	BattleEvents.piece_deselected.connect(_on_piece_deselected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_piece_selected(piece: ChessPiece):
	selected_piece = piece
	update_details()

func _on_piece_deselected():
	if !selected_piece:
		return
	actor_details.hide()
	selected_piece = null
	
func update_details():
	if !selected_piece:
		return
	profile_image.texture = selected_piece.actor_data.actor_profile_image
	class_level.text = "%s" % selected_piece.actor_data.actor_level
	actor_name.text = selected_piece.actor_data.actor_name
	chess_class.text = selected_piece.actor_data.actor_chess_class.display_name
	actor_details.visible = true
