class_name BoundState
const uuid_util = preload('./uuid.gd')


var state: State
var id: String
var targets: Array = Array()

func add_target(target, propertyName: String):
	targets.append({
		'target': target,
		'property': propertyName
	});

func _init(boundState: State):
	self.state = boundState
	self.id = uuid_util.uuidv4()
	boundState.state_update.connect(state_update);
	
func state_update(newValue):
	for target in targets:
		target.target[target.property] = newValue

