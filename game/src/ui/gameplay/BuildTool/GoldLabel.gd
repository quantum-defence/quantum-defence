extends Label

const start_gold = 10
export var curr_gold: int = 0
onready var arena = self.find_parent("Arena")


func _ready():
	reset()


func change_gold(gold_change: int) -> bool:
	if curr_gold + gold_change < 0:
		return false
	curr_gold += gold_change
	update_gold()
	return true


func set_gold(gold_set: int):
	if gold_set < 0:
		return false
	curr_gold = gold_set
	update_gold()
	return true


func update_gold():
	self.text = str(curr_gold)


func can_drop_data(position, data):
	return true


func drop_data(position, data):
	data["target_slot"] = data["origin_slot"]
	data["target_item"] = data["origin_item"]
	data["origin_slot"].texture = data["origin_texture"]


func reset():
	curr_gold = start_gold
	update_gold()
