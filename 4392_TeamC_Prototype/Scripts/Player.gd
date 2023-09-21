extends KinematicBody2D

# This script handles player movement
# It is attached to the root node of the player

# TODO: Add code logic to make the player move slower while 'backpedaling'


onready var NC = get_node("/root/RootNode/NoiseController")

export var moveSpeed = 200
var speedModifier = 1
var velocity = Vector2.ZERO

var lastFootstepTime = 0
var timeBetweenFootsteps = 350
var baseFootstepIntensity = 0.75

func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	
	if Input.is_action_pressed("sneak") or Input.is_action_pressed("aim"):
		speedModifier = 0.5
	elif Input.is_action_pressed("sprint"):
		speedModifier = 2
	else:
		speedModifier = 1
	
	if velocity != Vector2.ZERO and OS.get_ticks_msec() - lastFootstepTime > timeBetweenFootsteps:
		lastFootstepTime = OS.get_ticks_msec()
		NC.CreateNoise(global_position, baseFootstepIntensity*moveSpeed*speedModifier)
	
	move_and_slide(velocity*moveSpeed*speedModifier)
	
