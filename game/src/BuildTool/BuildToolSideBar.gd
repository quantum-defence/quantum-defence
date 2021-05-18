extends Node2D

var currentTower
var currentMap

#Color for the builder
export (Color, RGBA) var red
export (Color, RGBA) var yellow

var currentColor = yellow

#All the Towers
var firstTower = preload("res://src/Towers/BasicTower.tscn")
var secondTower = preload("res://src/Towers/RepeaterTower.tscn")
var thirdTower = preload("res://src/Towers/FastestTower.tscn")
var forthTower = preload("res://src/Towers/ShotGunTower.tscn")
var fifthTower = preload("res://src/Towers/UltimateTower.tscn")


func _ready():
	currentMap = self.get_parent()

func set_towerBuilder(otherTower):
	currentTower = otherTower

func _physics_process(delta):
	if (currentTower != null):
		var mouse_pos = get_global_mouse_position()

		