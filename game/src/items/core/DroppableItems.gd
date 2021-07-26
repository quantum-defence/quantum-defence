extends Control

#Idea is for the items to drop in map
#Therefore shud be the child of map
var rng = RandomNumberGenerator.new()
onready var build_UI = self.find_parent("Arena").get_node("UI/Control/BuildUI")

enum QUANTUAMITEM { H = 0, RY = 1, X = 2 }


func _get_quantum_items_instance(item: int) -> Item:
	var curr_item
	match item:
		QUANTUAMITEM.H:
			curr_item = load("res://src/items/otherDroppableItems/DroppableH.tscn")
		QUANTUAMITEM.RY:
			curr_item = load("res://src/items/otherDroppableItems/DroppableRY.tscn")
		QUANTUAMITEM.X:
			curr_item = load("res://src/items/otherDroppableItems/DroppableX.tscn")
	return curr_item.instance()


func _get_random_quantum_item():
	#X 10 percent chance, Ry 30 percent chance H 60 percent chance
	var roll = rng.randf_range(0, 100)
	if roll < 5:
		return _get_quantum_items_instance(2)
	elif roll >= 5 and roll < 30:
		return _get_quantum_items_instance(1)
	elif roll >= 30:
		return _get_quantum_items_instance(0)


func _on_DroppableItem_gui_input(event: InputEvent):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		var curr_item = self.get_child(0)
		build_UI._pick_up_item(curr_item)
		self.queue_free()
	return
