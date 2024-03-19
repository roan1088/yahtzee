extends Node2D

#var rng = RandomNumberGenerator.new()
var dices:Array[Node]
var values:Array[int]

func _ready():
	dices = get_tree().get_nodes_in_group("dice_group")
	values.resize(5)

func _on_roll_button_pressed():
	get_tree().call_group("dice_group", "roll")
	for i:int in 5:
		values[i] = dices[i].value
	print(values)
