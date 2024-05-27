extends Node2D

@export var credit = "."


@onready var label = $RichTextLabel

@onready var fade_in = $FadeIn

@onready var fade_out = $FadeOut

#fade in the text when the player enters

#fade out the text when the player exits

func _ready():
	label.text = credit



func fade_in_text():
	#take a new scene, fade to black, load new scene, go back to clear
	
	#fade in black box
	fade_in.interpolate_property(label, "modulate", 
		Color(0, 0, 0, 0), Color(0, 0, 0, 1), #color
		3.0, #time 
	  Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	fade_in.start()
	print("tween status: ", fade_in.is_active())

func fade_out_text():
	#take a new scene, fade to black, load new scene, go back to clear
	
	#fade in black box
	fade_in.interpolate_property(label, "modulate", 
		Color(0, 0, 0, 1), Color(0, 0, 0, 0), #color
		3.0, #time 
	  Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	fade_in.start()
	print("tween status: ", fade_in.is_active())




func _on_Area2D_body_entered(body):
		fade_in_text()
		


func _on_Area2D_body_exited(body):
#	fade_out_text()
	pass
