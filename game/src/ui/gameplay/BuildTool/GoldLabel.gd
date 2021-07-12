extends Label

const start_gold = 10
export var curr_gold : int = 0

func _ready():
	curr_gold = start_gold
	update_gold()

func change_gold(gold_change: int):
	curr_gold += gold_change	
	update_gold()

func set_gold(gold_set: int):
	curr_gold = gold_set
	
func update_gold():
	self.text = str(curr_gold)	

func can_drop_data(position, data):
	return true

func drop_data(position, data):
	data["target_slot"] = data["origin_slot"]
	data["target_item"] = data["origin_item"]
	data["origin_slot"].texture = data["origin_texture"]

func reset():
	_ready()
