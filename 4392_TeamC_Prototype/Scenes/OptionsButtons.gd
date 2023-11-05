extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
  var settings = $Settings
  var credits = $Credits
  settings.connect("pressed", self, "_settingsbutton_Pressed")
  credits.connect("pressed", self, "_creditbutton_Pressed")
  
func _settingsbutton_Pressed():
  var _set = get_tree().change_scene("res://Scenes/Settings.tscn")
  
func _creditbutton_Pressed():
  var _cred = get_tree().change_scene("res://Scenes/Credits.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
