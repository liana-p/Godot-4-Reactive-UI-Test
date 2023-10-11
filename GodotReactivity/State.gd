class_name State

signal state_update(value);

var id: String
func random_id():
	return str(randi() % 10000000000);
	
var state: get = get_state, set = set_state;

func _init(initialState):
	state = initialState;
	id = random_id();

func get_state():
	return state;

func set_state(value):
	state_update.emit(value);
	state = value;
