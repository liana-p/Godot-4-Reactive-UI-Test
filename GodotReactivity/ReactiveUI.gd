extends Node

var bound = {};

func bindLabel(button: Label, state: State):
	return bind(button, state, "text")

func bind(target, state: State, property: String):
	var boundState: BoundState;
	if (!bound[state]):
		boundState = BoundState.new(state);
		var id = boundState.id;
		bound[id] = boundState;
	else:
		boundState = bound[state.id];
	boundState.add_target(target, property);
