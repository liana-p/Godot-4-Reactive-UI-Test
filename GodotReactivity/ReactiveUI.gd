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

static func autobind(element, target, full_path: String, target_property: String, transform_func = null):
	var keys = path_to_keys(full_path);
	var reactive_path = keys.slice(0, -1);
	var reactive = get_reactive_from_array_path(target, reactive_path)
	var path = keys[-1];
	print("reactive_path ", reactive_path, " - path: ", path);
	return bind(element, reactive, path, target_property, transform_func);

static func get_reactive_from_array_path(target, path: PackedStringArray) -> Reactive:
	var result = target;
	for key in path:
		result = result[key];
	return result;

static func get_reactive(target, path: String) -> Reactive:
	var keys := path_to_keys(path);
	return get_reactive_from_array_path(target, keys);

static func path_to_keys(path: String) -> PackedStringArray:
	return path.split(".");
