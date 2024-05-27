extends Node2D

#Random Sound Container 2D
#add AudioStreamPlayer2D as children to this container

func play_random_sound(parent_position):
	var children = get_children()
	#play random sound from array children. can be any size
	var index = randi() % children.size()
	
	#print the sound and parent playing
#	print("playing sound #: ", str(self.get_name()),  " ", index)
	
	#set child position based on viewport
#	var random_position = Vector2(randi() % 1980, 1080)
#	print("random sound pos: ", random_position)
	if parent_position != null:
		children[index].position = Vector2(1920/2, 1080/2)
	children[index].play()
