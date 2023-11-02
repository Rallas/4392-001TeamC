extends StaticBody2D

onready var NC = get_node("/root/RootNode/NoiseController")
onready var ColliderNode = get_node("./CollisionShape2D")
onready var SpriteNode = get_node("./Sprite")

var noiseIntensity = 100
export var isClosed = true

# Called when the node enters the scene tree for the first time.
func _ready():
  updateState()
  pass

func updateState():
  if isClosed:
      ColliderNode.disabled = false
      SpriteNode.texture = preload("res://Sprites/Door_Closed.png")
  else:
      ColliderNode.disabled = true
      SpriteNode.texture = preload("res://Sprites/Door_Open.png")

# Object set to not be instant, so this will be called repeatedly while interacting.
func Interact():
  isClosed = not isClosed
  NC.CreateNoise(global_position, noiseIntensity)
  updateState()
