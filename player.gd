extends Area2D
class_name player

export var hp = 10

func hit(minus):
		hp -= minus

func _process(delta):
		var x = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
		var y = Input.get_action_strength("ui_down") -  Input.get_action_strength("ui_up")
		global_position.x += x * delta * 200
		global_position.y += y * delta * 200

