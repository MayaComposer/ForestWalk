extends Control
#script for volume sliders

#access the buses. SFX, Ambience, Music.
var music_bus = "Music"
var sfx_bus = "SFX"
var ui_bus = "UI"
var ambience_bus = "Ambience"

func _on_MasterSlider_value_changed(value):
	#set the master slider
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_MusicSlider_value_changed(value):
	#set the music slider
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(music_bus), linear_to_db(value))


func _on_SFXSlider_value_changed(value):
	#set the sfx, UI and phone slider
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(sfx_bus), linear_to_db(value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(ui_bus), linear_to_db(value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Phone"), linear_to_db(value))

func _on_AmbienceSlider_value_changed(value):
	#set the ambience
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(ambience_bus), linear_to_db(value))
