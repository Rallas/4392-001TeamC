extends KinematicBody2D

# This script handles player movement
# It is attached to the root node of the player

# TODO: Add code logic to make the player move slower while 'backpedaling'
# TODO: Make player emit noises every once in a while, with intensity proportional to current speed


export var moveSpeed = 200
var speedModifier = 1
var velocity = Vector2.ZERO

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
	
	move_and_slide(velocity*moveSpeed*speedModifier)
	
