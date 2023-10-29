extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
  var backButton = $Back
  backButton.connect("pressed", self, "_backButton_Pressed")

func _backButton_Pressed():
  var _back = get_tree().change_scene("res://Scenes/StartMenu.tscn")
