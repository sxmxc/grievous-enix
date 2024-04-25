extends StateMachine


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	state.on_mouse_entered()

func _on_area_2d_mouse_exited():
	state.on_mouse_exited()

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass
