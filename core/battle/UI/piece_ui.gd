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

func _get_drag_data(at_position):
	var drag_data = {}
	var preview_texture = TextureRect.new()
	preview_texture.texture = actor_data.actor_profile_image
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	
	drag_data["color"] = pieace_color
	drag_data["actor_data"] = actor_data
	return drag_data

func _can_drop_data(_pos, data):
	return false
