class_name State

signal state_update(value);

var state: get = get_state, set = set_state;

func _init(initialState):
	state = initialState;

func get_state():
	return state;

func set_state(value):
	state_update.emit(value);
	state = value;
