extends Panel
class_name BattlePanelLeft

@onready var actor_details = %ActorDetails
@onready var player_roster = %PlayerRoster
@onready var profile_image = %ProfileImage
@onready var class_level = %ClassLevel
@onready var chess_class = %ChessClass
@onready var actor_name =  %ActorName

var piece_ui_scene = preload("res://core/battle/UI/piece_ui.tscn") 

var player_roster_initialized := false

var selected_piece : ChessPiece = null 

var temp_player_roster : Array = [
	{
		"actor": "Valaris",
		"piece_color" : Color.DARK_CYAN,
		"actor_data" : DataManager.actor_database.find("Valaris")
	},
	{
		"actor": "Dev",
		"piece_color" : Color.DARK_GREEN,
		"actor_data" : DataManager.actor_database.find("Dev")
	},
	{
		"actor": "Voidmoose",
		"piece_color" : Color.DARK_ORANGE,
		"actor_data" : DataManager.actor_database.find("Voidmoose")
	},
]


# Called when the node enters the scene tree for the first time.
func _ready():
	BattleEvents.piece_selected.connect(_on_piece_selected)
	BattleEvents.piece_deselected.connect(_on_piece_deselected)
	init_player_roster(temp_player_roster)
	#SoundManager.play_music(DataManager.audio_database.find("battle_song_1"),1)
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

func init_player_roster(roster: Array):
	
	print("Initializing player roster")
	if player_roster_initialized:
		print("Player roseter already intialized -> Skipping")
	for member in roster:
		var entry = piece_ui_scene.instantiate()
		entry.init_with(member.actor_data, member.piece_color)
		
		%PlayerRoster.get_node("GridContainer").add_child(entry)
	player_roster_initialized = true
	print("Initializing player roster -> Done")

func update_details():
	if !selected_piece:
		return
	profile_image.texture = selected_piece.actor_data.actor_profile_image
	actor_name.text = selected_piece.actor_data.actor_name
	chess_class.text = selected_piece.actor_data.actor_chess_class.display_name
	actor_details.visible = true
