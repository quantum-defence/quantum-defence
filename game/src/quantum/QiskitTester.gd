extends Node

# First we strip comments and blank lines from the top-level version of MicroQiskit.py 
const shots = int(pow(10, 6))
onready var sim: QuantumSimulator = $Simulator
onready var QCircuit = preload('res://src/quantum/QuantumCircuit.gd')

# returns array of strings 
func simulate_and_get_memory(qc: QuantumCircuit, config={}) -> Array:
	config['get'] = 'memory';
	return sim.simulate(qc, config)

# returns dictionary: binary_repr: string => : int
func simulate_and_get_counts(qc: QuantumCircuit, config={}) -> Dictionary:
	config['get'] = 'counts';
	return sim.simulate(qc, config)

# returns dictionary: binary_repr: string => : float
func simulate_and_get_probabilities_dict(qc: QuantumCircuit, config={}) -> Dictionary:
	config['get'] = 'probabilities_dict';
	return sim.simulate(qc, config)

func simulate_and_get_statevector(qc: QuantumCircuit, config={}) -> PoolVector2Array:
	config['get'] = 'statevector';
	return sim.simulate(qc, config)

func _ready() -> void:
	print('try0')
	test_trig();
	print('try1')
	print( sim.simulate(newQC(1), { "shots": shots, "get": 'statevector'}))
	
	test_trig()
	test_x()
	test_h()
	test_rx()
	test_rz()
	test_ry()
	test_cx()
	test_memory()
	test_counts()
	test_add()
	test_multiqubit()
	test_noise ()
	print('Tests passed!')
	return

func newQC(x: int, y: int = 0) -> QuantumCircuit:
	var qc: QuantumCircuit = QCircuit.new()
	qc.set_circuit(x,y)
	return qc

func binary_to_decimal(binary: int) -> int:
	var input := binary
	var result := 0
	var digit_no := 0;
	while (input != 0):
		result += binary % 10 * int(pow(2, digit_no))
		digit_no += 1
		input /= 10
	return result

func compare_dicts(dict1: Dictionary, dict2: Dictionary) -> bool:
	if (dict1.keys().size() != dict2.keys().size()):
		return false
	for i in dict1.keys():
		if dict1[i] != dict2[i]:
			return false;
	return true

func compare_arrays(arr1: Array, arr2: Array) -> bool:
	if (arr1.size() != arr2.size()):
		return false
	for i in range(arr1.size()):
		if arr1[i] != arr2[i]:
			return false;
	return true

func test_trig():
	assert( sin(PI/2) == 1.0 )
	assert( cos(2*PI) == 1.0 )

func test_comparisons():
	var dict0 := { 'foo': 'bar', 'baz': 2 }
	var dict1 := { 'baz': 2, 'foo': 'bar' }
	var pva0 := PoolVector2Array()
	var pva1 := PoolVector2Array()
	pva0.append(Vector2.ZERO)
	pva1.append(Vector2.ZERO)
	pva0.append(Vector2(42, -91.08))
	pva1.append(Vector2(42, -91.08))
	pva0.append(Vector2(72, 1.62))
	pva1.append(Vector2(72, 1.62))
	assert (compare_dicts(dict0, dict1));
	assert (compare_arrays(pva0, pva1));
		
func test_x():
	var qc: QuantumCircuit
	qc = newQC(1)
	qc.x(0)
	assert(compare_arrays(
		simulate_and_get_statevector(qc, { "shots": shots }), 
		[Vector2(0.0, 0.0), Vector2(1.0, 0.0)]))
	qc = newQC(2)
	qc.x(1)
	assert(compare_arrays(
		simulate_and_get_statevector(qc, { "shots": shots }),
		[Vector2(0.0, 0.0), Vector2(0.0, 0.0), Vector2(1.0, 0.0), Vector2(0.0, 0.0)]))
	qc = newQC(2)
	qc.x(0)
	qc.x(1)
	assert(compare_arrays(
		simulate_and_get_statevector(qc, { "shots": shots }),
		[Vector2(0.0, 0.0), Vector2(0.0, 0.0), Vector2(0.0, 0.0), Vector2(1.0, 0.0)]))
	
func test_h():
	var qc := newQC(2)
	qc.h(0)
	assert(compare_arrays(
		simulate_and_get_statevector(qc, { "shots": shots }),
		[Vector2(0.70710678118, 0.0), Vector2(0.70710678118, 0.0), Vector2(0.0, 0.0), Vector2(0.0, 0.0)]))
	qc = newQC(2)
	qc.h(1)
	assert( compare_arrays(
		simulate_and_get_statevector(qc, { "shots": shots }),
		[Vector2(0.70710678118, 0.0), Vector2(0.0, 0.0), Vector2(0.70710678118, 0.0), Vector2(0.0, 0.0)]))
	qc = newQC(2)
	qc.h(0)
	qc.h(1)
	assert( compare_arrays(
		simulate_and_get_statevector(qc, { "shots": shots }),
		[
			Vector2(0.49999999999074046, 0.0), Vector2(0.49999999999074046, 0.0), 
			Vector2(0.49999999999074046, 0.0), Vector2(0.49999999999074046, 0.0)
		]))
		
func test_rx():
	var qc := newQC(1)
	qc.rx(PI/4, 0)
	assert( compare_arrays(
		simulate_and_get_statevector(qc),
		[Vector2(0.9238795325112867, 0.0), Vector2(0.0, -0.3826834323650898)]))
	qc = newQC(2)
	qc.rx(PI/4, 0)
	qc.rx(PI/8, 1)
	assert( compare_arrays(
		simulate_and_get_statevector(qc),
		[
			Vector2(0.9061274463528878, 0.0), Vector2(0.0, -0.37533027751786524),
			Vector2(0.0, -0.18023995550173696), Vector2(-0.0746578340503426, 0.0)
		]))
	qc.h(0)
	qc.h(1)
	assert( compare_arrays(
		simulate_and_get_statevector(qc),
		[
			Vector2(0.4157348061435736, -0.27778511650465676), Vector2(0.4903926401925336, 0.0975451610062577),
			Vector2(0.4903926401925336, -0.0975451610062577), Vector2(0.4157348061435736, 0.27778511650465676)
		]))

func test_rz():
	
	# arbitrary angles
	var tx := 2.8777603974458796
	var tz := 0.5589019778800038

	# an rz rotatation using h*rx*h
	var qcx := newQC(1)
	qcx.rx(tx, 0)
	qcx.h(0)
	qcx.rx(tz, 0)
	qcx.h(0)
	var ketx =  simulate_and_get_statevector(qcx)

	# a plain rz rotation
	var qcz := newQC(1)
	qcz.rx(tx, 0)
	qcz.rz(tz, 0)
	simulate_and_get_statevector(qcz)
	var ketz =  simulate_and_get_statevector(qcz)
	
	# check they are the same
	for j in range(2):
		for k in range(2):
			assert (round(ketx[j][k] * 1000) == round(ketz[j][k] * 1000))
				
func test_ry():
	var qc := newQC(1)
	qc.ry(PI/8, 0)
	assert( compare_arrays(
		simulate_and_get_statevector(qc),
		[Vector2(0.9807852803850672, -6.938893903907228 * pow(10,-17)), Vector2(0.19509032201251536, 0.0)]))
	
func test_cx():
	var qc := newQC(2)
	qc.h(0)
	qc.cx(0, 1)
	assert( compare_arrays(
		simulate_and_get_statevector(qc, { "shots": shots }),
		[Vector2(0.70710678118, 0.0), Vector2(0.0, 0.0), Vector2(0.0, 0.0), Vector2(0.70710678118, 0.0)]))
	qc = newQC(2)
	qc.x(0)
	qc.cx(0, 1)
	qc.cx(1, 0)
	qc.cx(0, 1)
	assert( compare_arrays(
		simulate_and_get_statevector(qc, { "shots": shots }),
		[Vector2(0.0, 0.0), Vector2(0.0, 0.0), Vector2(1.0, 0.0), Vector2(0.0, 0.0)] ))

func test_memory():
	var qc := newQC(2, 2)
	qc.h(0)
	qc.h(1)
	qc.measure(0, 0)
	qc.measure(1, 1)
	var m := simulate_and_get_memory(qc, { "shots": shots })
	assert( len(m) == shots )
	var p00 = 0
	for out in m:
		p00 += round(out == '00')/shots
	assert( round(p00 * 100) == 25 )
	qc = newQC(1, 1)
	qc.h(0)
	qc.measure(0, 0)
	m = simulate_and_get_memory(qc, { "shots": shots })
	assert( len(m) == shots )
	var p0 = 0
	for out in m:
		p0 += round(out == '0')/shots
	assert( round(p0 * 10) == 5 )

func test_counts():
	var qc := newQC(2, 2)
	qc.h(0)
	qc.h(1)
	qc.measure(0, 0)
	qc.measure(1, 1)
	var c := simulate_and_get_counts(qc, { "shots": shots })
	for out in c:
		var p = float(c[out])/shots
		assert( round(p * 100) == 0.25 )
		
func test_probs():
	var qc := newQC(2, 2)
	qc.h(0)
	qc.h(1)
	var p := simulate_and_get_probabilities_dict(qc, { "shots": shots })
	for out in p:
		assert( round(p[out] * 100) == 25 )
		
func test_add():
	for n in [1, 2]:
		var qc := newQC(n, n)
		var meas := newQC(n, n)
		for j in range(n):
			qc.h(j)
			meas.measure(j, j)
		var c := simulate_and_get_counts(qc.add(meas), {"shots": shots })
		for out in c:
			var p = float(c[out])/shots
			assert( round(p * 100) == round(1.0/ pow(2, n) * 100) )

func test_multiqubit():
	var qc := newQC(7, 7)
	qc.h(0)
	qc.cx(0, 2)
	qc.cx(2, 1)
	qc.h(5)
	qc.cx(5, 3)
	qc.cx(3, 4)
	qc.cx(3, 6)
	var ket =  simulate_and_get_statevector(qc, { "get": 'statevector' })
	var check = true
	for string in ['0000000', '0000111', '1111000', '1111111']:
		check = check and (round(ket[binary_to_decimal(int(string))][0] * 100) == 50)
	assert( check )
	for j in range(7):
		qc.measure(j, j)
	var counts := simulate_and_get_counts(qc, { "shots": shots })
	check = true
	for string in ['0000000', '0000111', '1111000', '1111111']:
		var p = float(counts[string])/shots
		check = check and round(p * 100) == 25
	assert( check )
		
func test_reorder ():
	var qc := newQC(2, 2)
	qc.x(0)
	qc.measure(0, 1)
	qc.measure(1, 0)
	var counts := simulate_and_get_counts(qc, { "shots": shots })
	assert (counts['01'] == shots)
	qc = newQC(5, 4)
	qc.x(1)
	qc.x(3)
	qc.x(4)
	qc.measure(1, 0)
	qc.measure(3, 1)
	qc.measure(4, 2)
	qc.measure(0, 3)
	counts = simulate_and_get_counts(qc, { "shots": shots })
	assert (counts['0111'] == shots)
	
func test_noise ():
	var qc := newQC(2, 2)
	var p := simulate_and_get_probabilities_dict(qc, { "noise_model": [0.1, 0.2]})
	var correct_p = {'00': 0.7200000000000001, '01': 0.08000000000000002, '10': 0.18000000000000002, '11': 0.020000000000000004}
	for out in correct_p:
		assert (p[out] == correct_p[out])
