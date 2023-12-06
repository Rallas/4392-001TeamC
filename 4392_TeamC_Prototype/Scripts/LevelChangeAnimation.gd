extends CanvasModulate

onready var _anim_player = $FadePlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  _anim_player.play_backwards("fade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
