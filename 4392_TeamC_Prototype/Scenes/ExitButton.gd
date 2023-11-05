extends CenterContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  var exitButton = $Quit
  exitButton.connect("pressed", self, "_exitButton_Pressed")

func _exitButton_Pressed():
  get_tree().quit()
