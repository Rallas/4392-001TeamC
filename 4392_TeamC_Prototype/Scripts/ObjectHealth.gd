extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var currentHealth = 100

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


func takeDamage(d):
  currentHealth -= d
  if currentHealth <= 0:
    get_parent().queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
