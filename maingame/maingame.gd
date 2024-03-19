extends Node2D

#var rng = RandomNumberGenerator.new()
var dices:Array[Node]
var values:Array[int]
var value_count:Array[int]
var scores:Array[int]

func _ready():
	dices = get_tree().get_nodes_in_group("dice_group")
	values.resize(5)
	value_count.resize(6)
	scores.resize(13)

func calcScores():
	value_count.fill(0)
	scores.fill(0)
	for i:int in 5:
		value_count[dices[i].value - 1] += 1
	print(value_count)
	# upper section and chance
	for i:int in 6:
		scores[i] = value_count[i] * (i + 1)
		scores[12] += scores[i] # chance = sum of all values
	# lower section
	var max_count:int = value_count.max()
	if (max_count == 5):
		scores[11] = 50 # yahtzee
		scores[6] = scores[12] # 3 of a kind
		scores[7] = scores[12] # 4 of a kind
		scores[8] = 25 # full house
	if (max_count == 4):
		scores[6] = scores[12] # 3 of a kind
		scores[7] = scores[12] # 4 of a kind
	if (max_count == 3):
		scores[6] = scores[12] # 3 of a kind
		if (value_count.has(2)):
			scores[8] = 25 # full house
	if (value_count[1] && value_count[2] && value_count[3] && value_count[4]):
		scores[9] = 30 # small straight
		if (value_count[0] || value_count[5]):
			scores[10] = 40 # large straight
	if (value_count[0] && value_count[1] && value_count[2] && value_count[3]):
		scores[9] = 30 # small straight
	if (value_count[2] && value_count[3] && value_count[4] && value_count[5]):
		scores[9] = 30 # small straight
	print(scores)

func _on_roll_button_pressed():
	get_tree().call_group("dice_group", "roll")
	for i:int in 5:
		values[i] = dices[i].value
	print(values)
	calcScores()
