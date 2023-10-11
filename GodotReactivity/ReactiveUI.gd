class_name ReactiveUI

static var bound: Dictionary = {};

static func bind_label(button: Label, state: Reactive, bound_property: String, transform_func = null):
	return bind(button, state, bound_property, "text", transform_func)

static func bind_progress_bar(progress: ProgressBar, state: Reactive, bound_property: String, transform_func = null):
	return bind(progress, state, bound_property, "value", transform_func);

static func bind(target, state: Reactive, bound_property: String, target_property: String, transform_func = null):
	var boundState: BoundState;
	if (!bound.has(state.id)):
		boundState = BoundState.new(state);
		bound[state.id] = boundState;
	else:
		boundState = bound[state.id];
	boundState.add_target(target, bound_property, target_property, transform_func);
