extends Node

#Used to tween the lowpass filter in and out

#access the low pass filter on the ambience bus
@onready var low_pass_filter = AudioServer.get_bus_effect(AudioServer.get_bus_index("Ambience"), 0)


@export (int) var low_cut = 1000
@export (int) var high_cut = 4500
#12 dB, 0.5 resonance

@onready var tween = $Tween

#edit filter so it becomes available globally in the sound manager
#without having to instance it (instance tween instead)

func _ready():
	#print("filter obj:", low_pass_filter)
	low_pass_filter.cutoff_hz = high_cut
	
func start():
	#tween filter to max
	tween.interpolate_property(
		low_pass_filter,        # context
		"cutoff_hz",         # property
		high_cut,             # from current value
		low_cut,             # to
		2.0,           # duration
		1,             # transition type
		tween.EASE_IN, # ease type
		0              # delay
	)
	tween.start()
	print("LPF on", str(low_pass_filter.cutoff_hz))


func stop():
	#tween chorus to max
	tween.interpolate_property(
		low_pass_filter,        # context
		"cutoff_hz",         # property
		low_cut,             # from current value
		high_cut,             # to
		2.0,           # duration
		1,             # transition type
		tween.EASE_IN, # ease type
		0              # delay
	)
	tween.start()
	print("LPF off", str(low_pass_filter.cutoff_hz))
