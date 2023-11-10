extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
  var credit = $Credits
  credit.connect("pressed", self, "_credit_button_pressed")

func _credit_button_pressed():
  var _cred = get_tree().change_scene("res://Scenes/Credits.tscn")
