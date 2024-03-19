extends Node2D

@export var value:int = 1
@export var locked:bool = false

var rng = RandomNumberGenerator.new()

func roll():
	if(!locked):
		$DiceFrames.play()
		value= rng.randi_range(1, 6)
		await get_tree().create_timer(0.7).timeout
		$DiceFrames.pause()
		$DiceFrames.frame = value - 1

func _on_dice_button_pressed():
	locked = !locked
	$LockedLabel.visible = locked
