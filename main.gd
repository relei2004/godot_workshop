extends Node2D
var Gegner = load("res://gegner.tscn")
var Goal = load("res://goal.tscn")

func _ready():
		randomize()
		$player.connect("area_entered",self,"_on_player_area_entered")
		#create_goal()
		connect_goals()

func create_goal():
		var goal = Goal.instance()
		goal.color = "#00FF00"
		goal.global_position.x = randi() % 1014
		goal.global_position.y = randi() % 600
		goal.connect("area_entered",self,"_on_goal_green_area_entered",[goal.getColor()])
		add_child(goal)

func connect_goals():
		for g in $goals.get_children():
				g.connect("area_entered",self,"_on_goal_green_area_entered",[g.getColor()])


func _process(delta):
		if $player.hp < 1:
				$player.visible = false


func _on_Timer_timeout():
		if get_child_count() > 5:
				return
		var gegner = Gegner.instance()
		gegner.global_position.x = randi() % 1014
		gegner.global_position.y = randi() % 600
		gegner.color = "#00FF00"
		add_child(gegner)


func _on_goal_green_area_entered(area,color):
		if !area.is_in_group("gegner"): 
				return

		if area.getColor() == color:
				area.catched = true

func _on_player_area_entered(area):
		if area.is_in_group("finish"):
				for i in get_children():
						if i.is_in_group("gegner"):
								if i.catched == false:
										return

				print("Gewonwnn")
				get_tree().reload_current_scene()

		if !area.is_in_group("gegner") && !area.is_in_group("shoot") :
				return
		$player.hit(1)
