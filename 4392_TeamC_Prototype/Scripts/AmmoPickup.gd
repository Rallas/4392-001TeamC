extends Node

onready var PlayerInventory = get_node("/root/RootNode/Player/Inventory")
onready var AmmoLabel = get_node("/root/RootNode/UI Container/AmmoLabel")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var pickupBullets = 8

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass


func _on_Area2D_body_entered(body):
  if body.is_in_group("Player"):
    PlayerInventory.numBullets += pickupBullets
    AmmoLabel.reserveAmmo = PlayerInventory.numBullets
    AmmoLabel.updateLabel()
    
    queue_free()
