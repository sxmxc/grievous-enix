extends Node
class_name State

var state_machine: StateMachine = null
var actor

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func on_mouse_entered():
	pass

func on_mouse_exited():
	pass

func physics_update(_delta: float) -> void:
	pass

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass
