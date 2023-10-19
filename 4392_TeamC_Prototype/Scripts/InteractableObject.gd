extends Area2D

export var instant = true
var playerInRange = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if instant:
		if playerInRange and Input.is_action_just_pressed("interact"):
			get_parent().Interact()
	else:
		if playerInRange and Input.is_action_pressed("interact"):
			get_parent().Interact()


func _on_InteractibleObject_body_entered(body):
	if body.is_in_group("Player"):
		playerInRange = true


func _on_InteractibleObject_body_exited(body):
	if body.is_in_group("Player"):
		playerInRange = false
