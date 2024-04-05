extends Resource
class_name ActorData

@export var actor_name: StringName
@export var actor_chess_class: ChessClass
@export_multiline var actor_description: String
@export var actor_profile_image : Texture2D
@export var actor_spritesheet : Texture2D
@export var actor_special_skills : Array[ChessSkill]
@export var actor_level : int
@export var actor_xp : int
@export var actor_xp_to_next_level: int
@export var actor_sp : int
@export var actor_sp_used: int
