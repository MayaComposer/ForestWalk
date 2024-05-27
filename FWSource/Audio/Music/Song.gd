extends Node

#generic song class
#will play the layers when it gets created
#inherit a song from this class

@export var start_layers = [] # (Array, String)

#play a song. It will start with either all the layers if you leave
#the array empty, or only fade in the layers you want
func play_song(init_layers : Array = []):
	#play all children, then check which need to be faded in
	var children = get_children()
	
	for l in children:
		if l.has_method("play"):
			#play
			l.play()
			
			#if no parameter is given, fade in all the layers
			if init_layers.is_empty():
				#fade in all layers
				_tween_volume(l, 0, 1.0)
			else:
				#check if the child exists in init_layers
				if init_layers.has(l.get_name()):
					_tween_volume(l, 0, 1.0)

			
			
func stop_song(fade_time : float):
	var layers = get_children()
	for l in layers:
		if l.has_method("play"):
			#fade out all layers
			_tween_volume(l, -80, fade_time)

#generic volume tween function
func _tween_volume(object : Node, target_value : float, duration : float):
	var tween = get_tree().create_tween()
	#tween filter to max
	tween.tween_property(
		object,        # context
		"volume_db",         # property
		target_value,            # to
		duration,           # duration in seconds
	)
	print("tween status: ", tween.is_running())
