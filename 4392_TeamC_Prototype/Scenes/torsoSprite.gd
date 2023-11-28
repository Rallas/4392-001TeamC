extends AnimatedSprite

onready var player = get_node("/root/RootNode/Player")
onready var torsoSprite = get_node("/root/RootNode/Player/torsoSprite")
onready var weap = get_tree().get_root().find_node("DefaultWeapon",true,false)

var target
var offAxisAngle
var myAngle

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    rotation = 0
    torsoSprite.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
    target = get_global_mouse_position() - global_position
    offAxisAngle = target.angle()
    myAngle = rotation
    rotation = lerp_angle(myAngle,offAxisAngle, 0.23)
    
    if weap.reloading:
        torsoSprite.play("reload")
    elif Input.is_action_pressed("aim"):
        torsoSprite.play("aiming")
    else:
        torsoSprite.play("standing down")


