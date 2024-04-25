extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func populate_ability_menu(abilities: Array[AbilitySkill]):
	for child in %Abilities.get_children():
		child.queue_free()
	var back_button = Button.new()
	back_button.text = "<- Back"
	%Abilities.add_child(back_button)
	back_button.pressed.connect(menu_back)
	for ability in abilities:
		var button = Button.new()
		button.text = ability.skill_name
		%Abilities.add_child(button)
		button.pressed.connect(ability.execute)

func menu_back():
	%Abilities.hide()
	%Main.show()
	pass
