extends Resource
class_name ActorData

@export var actor_name: StringName
@export var actor_chess_class: ChessClass
@export_multiline var actor_description: String
@export var actor_profile_image : Texture2D
@export var actor_known_skills: Array[ChessSkill]
@export var actor_special_skills : Array[ChessSkill]
@export var actor_xp : int
@export var actor_xp_to_next_level: int
@export var actor_sp : int
@export var actor_sp_used: int

func get_moves(pos: Vector2i) -> Array[Vector2i]:
	var modifier := 0
	for skill in actor_known_skills:
		if skill is MoveSkill:
			modifier += skill.move_modifier
	for skill in actor_special_skills:
		if skill is MoveSkill:
			modifier += skill.move_modifier
	var base_moves : Array[Vector2i] = actor_chess_class.get_movements(pos, modifier)
	return base_moves

func get_capture(pos: Vector2i) -> Array[Vector2i]:
	var captures = []
	for skill in actor_known_skills:
		if skill is MoveSkill:
			captures.append(skill.get_captures())
	for skill in actor_special_skills:
		if skill is MoveSkill:
			captures.append(skill.get_captures())
	return captures
