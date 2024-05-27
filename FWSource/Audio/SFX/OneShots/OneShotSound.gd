extends AudioStreamPlayer2D

#Object gets instanced, audio file plays. When the sound is done, the object gets deleted.
#Uses a mono .wav file
#use preload("path") for the audio scene you want to use
func _ready():
	var parent = get_parent()
	print("parent of sound: ", parent.get_name())
#	self.position = parent.position
	play()
	
func _on_AudioStreamPlayer2D_finished():
	queue_free()


func _on_AudioStreamPlayer_finished():
	queue_free()
