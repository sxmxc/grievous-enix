extends Control

@onready var focus_indicator = $FocusIndicator
@onready var color_indicator = $ColorIndicator as ColorRect
var focused := false
var actor_data : ActorData
var pieace_color: Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_indicator.color = pieace_color
	focus_indicator.visible = focused
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_with(actor: ActorData):
	actor_data = actor

func set_color(color: Color):
	pieace_color = color
