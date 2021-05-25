extends CanvasLayer

#Preload all the tower scenes to build
var obelisk = preload("res://src/environment/towers/pixelTowers/obelisk/Obelisk.tscn")
var flyingObelisk = preload("res://src/environment/towers/pixelTowers/flyingObelisk/flyingObelisk.tscn")
var lightningTotem = preload("res://src/environment/towers/pixelTowers/lightningTotem/LightningTotem.tscn")
var demonStatue = preload("res://src/environment/towers/pixelTowers/demonStatue/DemonStatue.tscn")
var moonTower = preload("res://src/environment/towers/pixelTowers/moonTower/MoonTower.tscn")
var eyeTower = preload("res://src/environment/towers/pixelTowers/eyeTower/EyeTower.tscn")

#if buildMode is not true, then it is in normal mode
var buildMode : bool = false
var tileIndicator  = preload("res://TileIndicator.tscn")
var tileIndicatorInstance 
#reference to the map that its on
onready var currentMap = self.get_parent()

# Called when the node enters the scene tree for the first time.

func _on_BuildMode_pressed():
	print(buildMode)
	buildMode = true
	print("Mouse shud be chagned")
	print(buildMode)

func _on_InspectMode_pressed():
	print(buildMode)
	buildMode = false
	print(buildMode)

func _process(delta):	
	if (buildMode and tileIndicatorInstance == null):
		print("reached here")
		tileIndicatorInstance = tileIndicator.instance()
		add_child(tileIndicatorInstance)
		print("tileIndicatorInstance is init")
		
	
func _input(event):
	if (buildMode):
		if (event is InputEventMouseButton):
			if event.pressed and Input.is_action_pressed("buildClick"):
				print("Clicker is working")
				var mouse_pos = get_viewport().get_mouse_position()
				print(self.get_parent())
				print(currentMap)
				currentMap.build_turret_at(mouse_pos)

				
#	if (isPlacing): 
#		var t := Transform2D.IDENTITY
#		t.origin = get_global_mouse_position()
#		var colliding = test_move(t, Vector2.ZERO)
#		position = t.origin
#		modulate = Color.red if colliding else Color.yellow
#		modulate.a = 0.75 
#		if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
#			isPlacing = false 
#	else:
#		modulate = Color.white
