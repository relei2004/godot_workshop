
extends Area2D

var Shoot = load("res://shoot.tscn")
var s
var r = 0
var angle = 0
var player
export var catched = false
export var viewDir = Vector2(1,0)
export var rotationSpeed = 1
export var speed = 100
export var distance = 300
export var catchedDistance = 400
export var color = "green"
export var shootOn = true
export var catchedShootOn = true
var targed = false
export var viewAngle = 50

func _ready():
		$ColorRect.color = color
		set_viewField()
		if shootOn == false:
				$shootTimer.paused = true

func get_player():
		return player
func getColor():
		return color

func _process(delta):

		player = get_parent().find_node("player")

		var c = global_position.direction_to(player.global_position)

		if targed == true:
				rotation = c.angle()
				if catched == false:
						global_position += delta * c * speed 
		else:
				rotation  += rotationSpeed * delta	

		if catched == true:
				on_catched()

func set_viewField():
		$viewField.global_position = global_position
		$viewField.polygon[0] = Vector2.ZERO
		$viewField.polygon[1] = Vector2(distance,-viewAngle)
		$viewField.polygon[2] = Vector2(distance,0)
		$viewField.polygon[3] = Vector2(distance,viewAngle)

		$viewArea/collViewField.global_position = global_position
		$viewArea/collViewField.polygon[0] = $viewField.polygon[0]
		$viewArea/collViewField.polygon[1] = $viewField.polygon[1]
		$viewArea/collViewField.polygon[2] = $viewField.polygon[2]
		$viewArea/collViewField.polygon[3] = $viewField.polygon[3]

func on_catched():
		if catched == true:
				if catchedShootOn == false:
						$shootTimer.paused = true
				else:
						print("shoot")
						$shootTimer.paused = false

				distance = catchedDistance

func shoot(dir):
		var shoot = Shoot.instance()
		shoot.global_position = global_position
		shoot.dir = dir
		get_parent().add_child(shoot)

func _on_shootTimer_timeout():
		if targed == false:
				return

		viewDir = global_position.direction_to(player.global_position)
		shoot(viewDir)

func _on_viewArea_area_entered(area):
		if !area.is_in_group("player"):
				return
		var c = global_position.direction_to(area.global_position)
		rotation = c.angle()
		targed = true

func _on_viewArea_area_exited(area):
		if !area.is_in_group("player"):
				return
		targed = false
