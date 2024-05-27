extends Node2D

@onready var sounds = $Sounds

var sound_list

var count = 0

func _ready():
	sound_list = sounds.get_children()
#
#	print("sound list: ", sound_list.size())
	
func play_sound():
	sound_list[count].play()
	
	if count == sound_list.size() - 1:
		count = 0
		sound_list.shuffle()
	else:
		count += 1
	
#	print("current count: ", count)
