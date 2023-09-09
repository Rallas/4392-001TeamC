extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export var moveSpeed = 200
var speedModifier = 1
var velocity = Vector2.ZERO

	

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
	
