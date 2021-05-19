extends Node2D

var currentTower
var currentMap

#Color for the builder
export (Color, RGBA) var red
export (Color, RGBA) var yellow

var currentColor = yellow

#All the Towers
# var firstTower = preload("res://src/environment/towers/BasicTower.tscn")
var secondTower = preload("res://src/environment/towers/RepeaterTower.tscn")
var thirdTower = preload("res://src/environment/towers/FastestTower.tscn")
var forthTower = preload("res://src/environment/towers/ShotGunTower.tscn")
var fifthTower = preload("res://src/environment/towers/UltimateTower.tscn")


func _ready():
	currentMap = self.get_parent()

func set_towerBuilder(otherTower):
	currentTower = otherTower

func _physics_process(delta):
	if (currentTower != null):
		var mouse_pos = get_global_mouse_position()

		
