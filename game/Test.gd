extends Node2D

onready var qn: QuantumNode = $QuantumNode
var probs: Dictionary
var qubit_called = 0

onready var func_ref


func _ready():
	qn.qc.set_circuit(1,1)

	#Set up all the functions to reference later
	func_ref = {
		"h" : funcref(qn.qc, "h"),
		"x" : funcref(qn.qc, "x"),
		"y" : funcref(qn.qc, "y"),
		"rx" : funcref(qn.qc, "rx"),
		"ry" : funcref(qn.qc, "ry"),
		"rz" : funcref(qn.qc, "rz"),
		"cx" : funcref(qn.qc, "cx"),
		"crx" : funcref(qn.qc, "crx")
	}

	func_ref["h"].call_func(qubit_called)
	probs = qn.simulate_and_get_probabilities_dict()
	print(probs)	
