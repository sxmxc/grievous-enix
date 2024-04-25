extends State

func handle_input(event: InputEvent):
	pass

func on_mouse_entered():
	state_machine.transition_to("Hovered")

func update(_delta):
	pass

func physics_update(_delta):
	pass

func enter(_msg = {}):
	pass

func exit():
	pass

