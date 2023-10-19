extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  var playButton = $StartGame
  var exitButton = $Quit
  playButton.connect("pressed", self, "_playButton_Pressed")
  exitButton.connect("pressed", self, "_exitButton_Pressed")

func _playButton_Pressed():
  #load the first scene
  get_tree().change_scene("res://Scenes/DefaultScene.tscn")

func _exitButton_Pressed():
  #exit out of application
  get_tree().quit()
