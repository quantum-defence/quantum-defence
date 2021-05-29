extends CanvasLayer


#Have yet to add angel tower
enum TowerTypes {
	OBELISK = 0,
	FLYINGOBELISK = 1, 
	LIGHTNINGTOTEM = 2, 
	DEMONSTATUE = 3,
	MOONTOWER = 4,
	EYETOWER = 5
}

#Preload all the tower scenes to build
const RESOURCE = ["res://src/environment/towers/pixelTowers/obelisk/Obelisk.tscn",
"res://src/environment/towers/pixelTowers/flyingObelisk/flyingObelisk.tscn",
"res://src/environment/towers/pixelTowers/lightningTotem/LightningTotem.tscn",
"res://src/environment/towers/pixelTowers/demonStatue/DemonStatue.tscn",
"res://src/environment/towers/pixelTowers/moonTower/MoonTower.tscn",
"res://src/environment/towers/pixelTowers/eyeTower/EyeTower.tscn"]

#if buildMode is not true, then it is in normal mode
var buildMode : bool = false
var tileIndicator  = preload("res://src/ui/gameplay/buildUI(new)/TileIndicator.tscn")
var tileIndicatorInstance

var tower_to_be_built : int
var item_held


#reference to the map that its on
onready var currentMap = self.get_parent()

# Called when the node enters the scene tree for the first time.

func _on_BuildMode_pressed():
	print("buildMode pressed")
	buildMode = true

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


func _on_ObeliskTower_pressed():
	print("ObeliskTowerSelected")
	tower_to_be_built = TowerTypes.OBELISK
	pass


func _on_FlyingObelisk_pressed():
	print("FlyingObeliskTowerSelected")
	tower_to_be_built = TowerTypes.FLYINGOBELISK
	pass # Replace with function body.


func _on_LightningTotem_pressed():
	print("LightningTotem Selected")
	tower_to_be_built = TowerTypes.LIGHTNINGTOTEM
	pass # Replace with function body.


func _on_DemonStatue_pressed():
	print("DemonStatue selected")
	tower_to_be_built = TowerTypes.DEMONSTATUE
	pass # Replace with function body.


func _on_MoonTower_pressed():
	print("MoonTower selected")
	tower_to_be_built = TowerTypes.MOONTOWER
	pass # Replace with function body.


func _on_EyeTower_pressed():
	print("EyeTower selected")
	tower_to_be_built = TowerTypes.EYETOWER	
	pass # Replace with function body.
