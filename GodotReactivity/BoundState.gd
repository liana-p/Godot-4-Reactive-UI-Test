class_name BoundState


var state: Reactive;
var targets: Array[BoundTarget] = [];

func add_target(target, bound_property: String, target_property, transform_func = null):
	var bound_target = BoundTarget.new(target, bound_property, target_property, transform_func);
	targets.append(bound_target);
	update_target_auto(bound_target);

func _init(boundState: Reactive):
	self.state = boundState
	boundState.value_changed.connect(state_update);

func state_update(property: String, newValue):
	for target in targets:
		if (target.bound_property == property):
			update_target(target, newValue);

func update_target_auto(bound_target: BoundTarget):
	var bound_property = bound_target.bound_property;
	return update_target(bound_target, state.get(bound_property));

func update_target(bound_target: BoundTarget, value):
	var target_property = bound_target.target_property;
	var target = bound_target.target;
	var transform_func = bound_target.transform_func;

	var result = value
	if transform_func is Callable:
		result = transform_func.call(result, bound_target);
	target.set(target_property, result);
