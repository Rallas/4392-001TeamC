extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    var playButton = $Start
    playButton.connect("pressed", self, "_playButton_Pressed")
      
func _playButton_Pressed():
    var _ret = get_tree().change_scene(Global.GetSceneForLevel(1))
