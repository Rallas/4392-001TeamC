extends Node


onready var PlayerInventory = get_node("/root/RootNode/Player/Inventory")


# Object set to not be instant, so this will be called repeatedly while interacting.
func Interact():
  if PlayerInventory.carryingKey:
    var _ret = get_tree().change_scene("res://Scenes/StartMenu.tscn")

