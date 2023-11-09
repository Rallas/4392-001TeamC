extends ColorRect

# Temp script for tutorial text until we make a real pause menu
# Hitting ESC toggles the controls screen
# It also disappears after 3 seconds if not dismissed manually

var shouldTimeout = false
var timeout


func _ready():
  visible = false
  if not Global.AlreadySeenControlPopup:
    Global.AlreadySeenControlPopup = true
    visible = true
    shouldTimeout = true
    timeout = OS.get_ticks_msec() + 3000
    


func _process(_delta):
    if shouldTimeout and OS.get_ticks_msec() > timeout:
        shouldTimeout = false
        visible = false
        
    if Input.is_action_just_pressed("ui_cancel"):
        shouldTimeout = false
        visible = not visible
