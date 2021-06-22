extends Tower

onready var qn: QuantumNode = $QuantumNode
var probs: Dictionary

func _ready() -> void:
	qn.qc.set_circuit(1,1)
	qn.qc.h(0)
	probs = qn.simulate_and_get_probabilities_dict()
	print(probs)

func _fire():
	var weapon = ._fire()
	weapon.set_prob(probs)
