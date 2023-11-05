extends CenterContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  var optionsButton = $Options
  optionsButton.connect("pressed", self, "_optionsButton_Pressed")  

func _optionsButton_Pressed():
  var _opt = get_tree().change_scene("res://Scenes/OptionsMenu.tscn")
