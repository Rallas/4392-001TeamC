extends AnimatedSprite

onready var enemy = get_parent()
onready var animsprite = get_parent().get_node("zomlegs")
var currvel = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
    currvel = enemy.moveTarget
    
    if currvel != Vector2.ZERO:
        look_at(currvel)
    
    if enemy.isStill == true:
        animsprite.play("idle")
    elif currvel != Vector2.ZERO and !(enemy.followingNoise):
        animsprite.play("sneak")
    elif currvel != Vector2.ZERO and (enemy.followingNoise):
        animsprite.play("run")
    else:
        animsprite.stop()
