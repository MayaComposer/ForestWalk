extends AudioStreamPlayer

#Object gets instanced, audio file plays. When the sound is done, the object gets deleted.
#use preload("path") for the audio scene you want to use

func _ready():
	play()

func _on_AudioStreamPlayer_finished():
	queue_free()
