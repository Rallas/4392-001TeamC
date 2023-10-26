extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
onready var PlayerInventory = get_node("/root/RootNode/Player/Inventory")


func _on_Area2D_body_entered(body):
  if body.is_in_group("Player"):
    PlayerInventory.carryingKey = true
    queue_free()
