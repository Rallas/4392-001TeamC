extends CanvasLayer


var gameIsPaused = false

onready var ControlsPopup = get_node("ControlsBG")
onready var DebugPopup = get_node("DebugScreenBG")
onready var DebugInput = get_node("DebugScreenBG/PlayerInput")

func _ready():
  pause_mode = Node.PAUSE_MODE_PROCESS
  gameIsPaused = false
  visible = false
    
func _process(_delta):
  if Input.is_action_just_pressed("ui_cancel"):
    if gameIsPaused:
      UnpauseGame()
    else:
      PauseGame()
      
  if Input.is_action_just_pressed("debug_console"):
    if !gameIsPaused:
      PauseGame()
      
    DebugPopup.visible = true
    DebugInput.grab_focus()
    
    
  if gameIsPaused and DebugPopup.visible and Input.is_action_just_pressed("ui_accept"):
    _on_DebugSubmit_pressed()

func PauseGame():
  get_tree().paused = true
  gameIsPaused = true
  visible = true
  ControlsPopup.visible = false
  DebugPopup.visible = false
  
func UnpauseGame():
  get_tree().paused = false
  gameIsPaused = false
  visible = false
  ControlsPopup.visible = false
  DebugPopup.visible = false


func _on_ResumeButton_pressed():
  UnpauseGame()


func _on_QuitButton_pressed():
  get_tree().paused = false
  var _opt = get_tree().change_scene("res://Scenes/StartMenu.tscn")
  


func _on_ControlsButton_pressed():
  ControlsPopup.visible = true


func _on_ControlsCloseButton_pressed():
  ControlsPopup.visible = false


func _on_DebugCloseButton_pressed():
  DebugPopup.visible = false


func _on_DebugSubmit_pressed():
  
  var inputStr = DebugInput.text
  
  if inputStr == "ammo":
    PlayerInventory.numBullets += 32
  
  # If input matches "goto{number}" go to that level
  elif inputStr.begins_with("goto") and inputStr.substr(4).is_valid_integer():
    Global.CurrentLevel = int(inputStr.substr(4))
    UnpauseGame()
    var _ret = get_tree().change_scene(Global.GetSceneForCurrentLevel())
    
  else:
    print("Invalid code")
