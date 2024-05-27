extends Node
#song means a piece of audio that loops.
#layer means a part of a song that you can add and remove
#I hope that makes sense >.<


#keep track of the song currently playing
var current_song : String = ""

var previous_song : String = ""

var music_path = "res://Audio/Music"
var music_dictionary = {}

#check if all the nodes exist
func _ready():
	##populate music dict and instance
	populate_item_dictionaries(music_path, music_dictionary, "FF_Mus_")
	print(music_dictionary)
	
	#instance song nodes
	for key in music_dictionary:
		# Insert the key and value into a text string
		_create_song_instance(key, music_dictionary)
	start_new_song("Denial")

##add crossfade function where youfade out current song and fade in new song
func start_new_song(new_song : String):
	#fades out the current song 
	#fades in the new song
	#uses tweens
	#grabs the new song
	var new_song_node = get_node(new_song)
	
	#starts each layer over the song
	new_song_node.play_song()
	
	#stops current song
	
	#set previous song
	previous_song = current_song
	#set current song
	current_song = new_song

func _stop_song(fade_time : float):
	var current_song_node = get_node(current_song)
	current_song_node.stop_song(fade_time)
	
#this works (I hope) IT WORKS
func add_music_layer(song, layer):
	#add layer
	#get the node
	var layer_node = get_node(song).get_node(layer)
	#set the volume to 0
	_tween_volume(layer_node, 0, 2.0)

#this works
func remove_music_layer(song, layer):
	#remove a layer
	#get the node
	var layer_node = get_node(song).get_node(layer)
	#reduce the volume to -80
	_tween_volume(layer_node, -80, 2.0)


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


func populate_item_dictionaries(dir_path : String, dictionary : Dictionary, prefix : String):
	#open the given directory path
	var dir = DirAccess.open(dir_path)
	
	#start reading the directory
	dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547

	while true:
		var file = dir.get_next()
		#if the file is empty, stop the while loop
		if file == "":
			break
		#else check for while that don't start with .
		elif not file.begins_with("."):
			#check the scenes with the given prefix
			if file.begins_with(prefix):
				#get the item path. Adds file var to the string (FF_SFX)
				var itempath = dir_path+"/"+file+"/"+file+".tscn"
				
				#loads te script
				#add to dictionary
				dictionary[file.trim_prefix(prefix)] = itempath
				
	dir.list_dir_end()

func _create_song_instance(song_name : String, dict : Dictionary):
	var song_object = load(dict[song_name])
	
	var song_instance = song_object.instance()
	add_child(song_instance)
	
	return song_instance
