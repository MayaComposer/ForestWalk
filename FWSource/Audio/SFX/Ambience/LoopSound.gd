extends AudioStreamPlayer
#A single sound that loops

func _ready():
	play()
	
func stop_ambience():
	stop()
	queue_free()


func _on_Button_pressed():
	#don't forget to remove
	stop_ambience()
	SoundManager.LPF.stop()
