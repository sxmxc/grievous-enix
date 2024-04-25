extends State

var starting_square: Vector2i

func handle_input(event: InputEvent):
	if actor.dragging and not event.is_action_pressed("left_click"):
		var target = actor.get_global_mouse_position()
		var board_square = BattleManager.current_board.world_to_board(target)
		if is_valid_drop(board_square):
			var tween = get_tree().create_tween()
			tween.tween_property(actor, "global_position" ,BattleManager.current_board.board_to_world(board_square),.2)
			SoundManager.play_sound(DataManager.audio_database.find("drop"))
			state_machine.transition_to("OnBoard")
			BattleEvents.piece_moved.emit()
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(actor, "global_position" ,BattleManager.current_board.board_to_world(starting_square),.2)
			SoundManager.play_sound(DataManager.audio_database.find("error"))
			state_machine.transition_to("OnBoard")
	pass

func update(_delta):
	actor.global_position = actor.get_global_mouse_position()
	var board = BattleManager.current_board as TileMap
	var board_square = board.world_to_board(actor.get_global_mouse_position())
	var square_indicator = BattleManager.square_indicator as Sprite2D
	
	square_indicator.global_position = board.board_to_world(board_square)
	var data = board.get_cell_tile_data(0, board_square)
	
	if !data:
		square_indicator.hide()
		return
		
	square_indicator.show()
	if !is_valid_drop(board_square):
		square_indicator.modulate = Color.RED
	else:
		square_indicator.modulate = Color.GREEN
	pass

func physics_update(_delta):
	pass

func enter(_msg = {}):
	starting_square = BattleManager.current_board.world_to_board(actor.global_position)
	actor.focus_indicator.show()
	var board_square = BattleManager.current_board.world_to_board(actor.get_global_mouse_position())
	BattleManager.square_indicator.global_position = BattleManager.current_board.board_to_world(board_square)
	actor.dragging = true
	pass

func exit():
	actor.focus_indicator.hide()
	BattleManager.square_indicator.hide()
	actor.dragging = false
	pass

func is_valid_drop(square: Vector2i):
	if !square in actor.actor_data.get_moves(starting_square):
		return false
	var blocked = BattleManager.current_board.is_square_blocked(square)
	match blocked:
		true, null:
			return false
		false:
			return true
