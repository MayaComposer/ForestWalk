extends Node
#Global script with SFX functions
#Autoload "SoundManager.tscn in project settings

#access to LPF scene
@onready var LPF = $LowPassFilter
#use LPF.start and LPF.stop()

#sound scene dictionaries

#???
var DICT_SOUND_ITEMS = []


var DICT_SFX = {}

var DICT_Ambience = {}

var DICT_UI = {}

#folder paths
var ambience_path = "res://Audio/SFX/Ambience"
var SFX_path = "res://Audio/SFX/OneShots"
var UI_path = "res://Audio/SFX/UI"

#sound prefixes
var ambience_prefix = "FF_Ambient_"
var SFX_prefix = "FF_SFX_"
var UI_prefix = "FF_UI_"

func _ready():
	
#	LPF.start()
	#populate each dictionary
	populate_item_dictionaries(ambience_path, DICT_Ambience, "FF_Ambient_")
	populate_item_dictionaries(SFX_path, DICT_SFX, "FF_SFX_")
	populate_item_dictionaries(UI_path, DICT_UI, "FF_UI_")
	
	#print the dicts
#	print("SFX dictionary", DICT_SFX)
#	print(".")
#	print("Ambient dictionary", "/n", DICT_Ambience)
#	print(".")
#	print("UI sound dictionary", "/n", DICT_UI)
	
	play_sound_2D("wibllywobbly", self)

#use this to instance a 2D sound. Needs the name of the sound and the intended parent node
func play_sound_2D(sound_name : String, parent : Node = null):
	#check each dictionary for the sound
	#check each dictionary for the sound
	if _play_sound_2D(sound_name, DICT_Ambience, parent) or _play_sound_2D(sound_name, DICT_SFX, parent) or _play_sound_2D(sound_name, DICT_UI, parent):
		print("playing sound: ", sound_name) 
		return
	else:
		print(sound_name, " doesn't exist")

func _play_sound_2D(sound_name : String, dict : Dictionary, parent):
	if dict.has(sound_name):
		#instance the sound and add as child to parent
		#node itself has play on start
		var sound_instance = _create_sound_instance(sound_name, dict)
		if parent != null:
			parent.add_child(sound_instance)
			return true
		else:
			add_child(sound_instance)
			return false
		
#use this to instance 2 stereo sound (UI, ambience)
func play_sound_stereo(sound_name : String):
	#check each dictionary for the sound
	#check each dictionary for the sound
	if _play_sound_stereo(sound_name, DICT_Ambience) or _play_sound_stereo(sound_name, DICT_SFX) or _play_sound_stereo(sound_name, DICT_UI):
		print("playing sound: ", sound_name) 
		return
	else:
		print(sound_name, " doesn't exist")

func _play_sound_stereo(sound_name : String, dict : Dictionary):
	if dict.has(sound_name):
		#instance the sound and add as child to parent
		#node itself has play on start
		var sound_instance = _create_sound_instance(sound_name, dict)
		add_child(sound_instance)
		return true
	else:
		return false


func stop_sound(sound_name : String, parent : Node = self):
	#stop the sound
	#delete the sound if it's 2D
	if parent != null:
		#access the sound node
		var node = parent.get_node(sound_name)
		if node != null:
			node.queue_free()
		else:
			print("tried to delete non-existent sound node")
	#delete the node if it's in SoundManager.tscn
	else:
		#access the sound node
		var node = get_node(sound_name)
		node.queue_free()
	
		
#create an instance of the sound
func _create_sound_instance(sound_name : String, dict : Dictionary):
	var sound_object = load(dict[sound_name])
	
	var sound_instance = sound_object.instance()
	
	return sound_instance
	
#generic function for loading SFX scenes into dictionaries
func populate_item_dictionaries(dir_path : String, dictionary : Dictionary, prefix : String):
	#open the given directory path
	var dir = DirAccess.new()
	dir.open(dir_path)
	
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
				
				
				#I still don't understand the use of a list here lol
				var obj_file_name = file.trim_prefix(prefix)
				obj_file_name = "Object_"+obj_file_name
				
				#add to list???
				DICT_SOUND_ITEMS.append(obj_file_name)
				
	dir.list_dir_end()
