 extends Node
#loops a sound with a specific start and end point

#start --> loop isn't smooth yet (code error)

@onready var loop = $Loop
@onready var end = $End

func _ready():
	print("LoopSoundEnd added")
	loop.play()
	
#plays the loop. Needs to have the start of the loop and looping point
func play_loop():
	loop.play()

#ends the loop and plays the tail
func play_end():
	loop.stop()
	end.play()

func _on_End_finished():
	#remove from tree when finished
	queue_free()
