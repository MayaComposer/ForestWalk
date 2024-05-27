extends Node

#Random Sound Container
#add audiostreamplayers as children to this container

func play_random_sound():
	var children = get_children()
	
	#play random sound from array children. can be any size
	var index = randi() % children.size()
	
	#print the sound and parent playing
#	print("playing sound #: ", children[index].get_name())
	
	children[index].play()
