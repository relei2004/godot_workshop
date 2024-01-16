extends Area2D

export var color = "#00FF00"

func _ready():
		$ColorRect.color = color
		pass
func getColor():
		return color
