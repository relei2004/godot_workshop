extends Area2D

export var dir = Vector2(1,0)
export var speed = 1000

func _ready():
	pass # Replace with function body.

func _process(delta):
		global_position += delta * speed * dir


