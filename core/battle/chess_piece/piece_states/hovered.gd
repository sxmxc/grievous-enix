extends State


func handle_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not actor.dragging and event.is_pressed():
			state_machine.transition_to("Selected")
	pass

func on_mouse_exited():
	state_machine.transition_to("OnBoard")

func update(_delta):
	pass

func physics_update(_delta):
	pass

func enter(_msg = {}):
	if not actor.dragging:
		actor.scale = Vector2(1.05,1.05)
	pass

func exit():
	if not actor.dragging:
		actor.scale = Vector2(1,1)
	pass
