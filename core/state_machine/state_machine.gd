extends Node
class_name StateMachine

signal transitioned(state_name)

@export var initial_state := NodePath()

@onready var state: State = get_node(initial_state)
@onready var current_state_name := state.name

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	for child: State in get_children():
		child.state_machine = self
		child.actor = owner
	state.enter()
	pass # Replace with function body.

func _unhandled_input(event):
	state.handle_input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state.update(delta)

func _physics_process(delta):
	state.update(delta)

func transition_to(target_state_name: String, msg: Dictionary = {}):
	if not has_node(target_state_name):
		return
	state.exit()
	state = get_node(target_state_name)
	current_state_name = state.name
	state.enter(msg)
	transitioned.emit(state.name)

func _on_area_2d_mouse_entered():
	state.on_mouse_entered()

func _on_area_2d_mouse_exited():
	state.on_mouse_exited()

func _on_area_2d_input_event(viewport, event, shape_idx):
	pass
