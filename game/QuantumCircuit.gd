extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

class_name QuantumCircuit

var num_qubits : int 
var num_clbits : int = 0
var circuit_name : String 
var circuit_data
var pi = VisualScriptMathConstant.MATH_CONSTANT_PI

func _ready():
	self.num_qubits = 0
	self.num_clbits = 0
	self.circuit_name = ""
	self.circuit_data = []

func _set_circuit(number_of_qubits: int, number_of_clbits: int):
  self.num_qubits = number_of_qubits
  self.num_clbits = number_of_clbits
  self.circuit_data = []

func _name_circuit(circuit_name: String):
  self.circuit_name = circuit_name

func __add__(otherQuantumCircuit: QuantumCircuit):
  var new_quantum_circuit = QuantumCircuit.instance()
  var max_qubits = max(self.num_qubits, otherQuantumCircuit.num_qubits)
  var max_clbits = max(self.num_clbits, otherQuantumCircuit.num_clbits)
  new_quantum_circuit._set_circuit(max_qubits, max_clbits)
  new_quantum_circuit.circuit_data= self.circuit_data.append_array((otherQuantumCircuit.data))
  new_quantum_circuit.circuit_name = self.circuit_name
  return new_quantum_circuit

#Not sure what this function is for
# func initialize(k):
#   self.circuit_data= [] 
#   self.circuit_data.append(('init',[e for e in k])) 

func x(q):
  var temp = ['x', q]
  self.circuit_data.append(temp)

func rx(theta,q):
  var temp = ['rx', theta, q]
  self.circuit_data.append(temp)

func rz(theta,q):
  var temp = ['rz', theta, q]
  self.circuit_data.append(temp)

func h(q):
  var temp = ['h', q]
  self.circuit_data.append(temp)

func cx(s,t):
  var temp = ['cx', s, t]
  self.circuit_data.append(temp)

func crx(theta,s,t):
  var temp = ['cx', s, t]
  self.circuit_data.append(temp)


func measure(q,b):
	if (b < self.num_clbit):
		print("Index for bits out of range")
	elif (q < self. num_qubits):
		print("Index for qubit out of range.")
	var temp = ['m', q, b]
	self.circuit_data.append(temp)

func ry(theta,q):
  self.rx(pi/2,q)
  self.rz(theta,q)
  self.rx(-pi/2,q)

func z(q):
  self.rz(pi,q)

func y(q):
  self.rz(pi,q)
  self.x(q)
