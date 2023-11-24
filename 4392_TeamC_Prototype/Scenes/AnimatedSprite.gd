extends AnimatedSprite

onready var player = get_node("/root/RootNode/Player")
onready var animsprite = get_node("/root/RootNode/Player/AnimatedSprite")
var currvel 
var inverseVel #neccessary to get back pedaling to work right


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
    currvel = player.moveAndSlideVel
    
    if currvel == Vector2.ZERO:
        look_at(get_global_mouse_position())
    
    if player.isBackpedaling:
        inverseVel = Vector2(0,0)-currvel
        rotation = (inverseVel.angle())
    elif currvel != Vector2.ZERO:
        rotation = currvel.angle()
    
    if currvel != Vector2.ZERO and (player.isBackpedaling or Input.is_action_pressed("sneak") or Input.is_action_pressed("aim")):
        animsprite.play("sneak")
    elif currvel == Vector2.ZERO:
        animsprite.play("idle")
    elif currvel != Vector2.ZERO and (Input.is_action_pressed("sprint") and !(player.isBackpedaling or Input.is_action_pressed("sneak") or Input.is_action_pressed("aim"))):
        animsprite.play("run")
    elif currvel != Vector2.ZERO:
        animsprite.play("move")
    else:
        animsprite.stop()
    
        
        
        
