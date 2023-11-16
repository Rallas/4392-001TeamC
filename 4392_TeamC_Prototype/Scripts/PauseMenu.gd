extends CanvasLayer


var gameIsPaused = false

onready var ControlsPopup = get_node("ControlsBG")

func _ready():
  pause_mode = Node.PAUSE_MODE_PROCESS
  gameIsPaused = false
  visible = false
    
func _process(_delta):
  if Input.is_action_just_pressed("ui_cancel"):
    print("pressed esc")
    if gameIsPaused:
      UnpauseGame()
    else:
      PauseGame()
    

func PauseGame():
  get_tree().paused = true
  gameIsPaused = true
  visible = true
  ControlsPopup.visible = false
  
func UnpauseGame():
  get_tree().paused = false
  gameIsPaused = false
  visible = false
  ControlsPopup.visible = false


func _on_ResumeButton_pressed():
  UnpauseGame()


func _on_QuitButton_pressed():
  get_tree().paused = false
  var _opt = get_tree().change_scene("res://Scenes/StartMenu.tscn")
  


func _on_ControlsButton_pressed():
  ControlsPopup.visible = true


func _on_ControlsCloseButton_pressed():
  ControlsPopup.visible = false
