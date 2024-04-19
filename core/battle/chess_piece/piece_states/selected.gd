extends State

func handle_input(event: InputEvent):		
	if event is InputEventMouseButton and event.is_pressed():
		if event.is_action_pressed("right_click"):
			state_machine.transition_to("OnBoard")
		if event.is_action_pressed("left_click"):
			state_machine.transition_to("Dragging")
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func enter(_msg = {}):
	actor.focus_indicator.show()
	actor.piece_menu.show()
	BattleEvents.piece_selected.emit(actor)
	pass

func exit():
	actor.focus_indicator.hide()
	actor.piece_menu.hide()
	BattleEvents.piece_deselected.emit()
	pass

