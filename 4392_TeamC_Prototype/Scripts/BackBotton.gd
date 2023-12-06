extends Control

var hoverAudio = preload("res://Resources/Audio/Title_Screen/click1.wav")
var clickAudio = preload("res://Resources/Audio/Title_Screen/switch4.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
  var backButton = $Back
  backButton.connect("pressed", self, "_backButton_Pressed")

func _backButton_Pressed():

  yield(get_tree().create_timer(.3), "timeout")
  var _back = get_tree().change_scene("res://Scenes/StartMenu.tscn")

