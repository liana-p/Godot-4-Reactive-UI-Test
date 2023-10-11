class_name Reactive

const PRIMITIVE = -1;

signal value_changed(property: String, value);

var state
var id: String;
var stateType;
var properties: Array[Dictionary] = [];

func random_id():
	return str(randi() % 10000000000);

func _init(initialValue):
	id = random_id();
	print("Setup Reactive: ", initialValue);
	state = initialValue;
	if (state is Dictionary):
		print("Value is dictionary");
		stateType = TYPE_DICTIONARY;
	elif (state is Array):
		print("Value is array");
		stateType = TYPE_ARRAY;
	else:
		print("Value is primitive");
		stateType = PRIMITIVE;
	generate_reactivity(state);
	generate_properties_list();

func generate_reactivity(value):
	if (value is Dictionary):
		for key in value.keys():
			value[key] = setup_value(key, value[key]);
	elif (value is Array):
		for i in range(value.size()):
			value[i] = setup_value(i, value[i]);

func setup_value(key, value):
	if (value is Dictionary || value is Array):
		print("Setup value: ", key, " is dictionary or array: ", value);
		return Reactive.new(value);
	else:
		print("Setup value: ", key, " is primitive: ", value)
		return value;


func generate_properties_list():
	print("Generate properties list")
	properties = [{
		'name': '__reactiveId',
		'type': typeof(id)
	},
	{
		'name': 'value_changed',
		'type': typeof(value_changed),
	}];
	if (stateType == TYPE_DICTIONARY):
		for key in state:
			properties.append({
				'name': key,
				'type': typeof(state[key])
			});
	print("Properties: ", properties);

func _get(property):
	if (property == '__reactiveId'):
		return id;
	if (stateType == TYPE_DICTIONARY):
		if state.has(property):
			return state[property];
		else:
			return null;
	else:
		return null;

func _set(property, value):
	print("Set: ", property, " to ", value);
	set_prop(property, value);
	generate_properties_list();
	value_changed.emit(property, value);
	return true

func set_prop(property, value):
	if (stateType == TYPE_DICTIONARY):
		if state.has(property):
			print("Overriding existing dictionary value")
			return override_value(property, value);
		else:
			print("Adding new value to dictionary");
			state[property] = setup_value(property, value);
	elif (stateType == TYPE_ARRAY):
		if (property < state.size()):
			print("Overriding existing array value")
			return override_value(property, value);
		else:
			print("Adding new value to array");
			state[property] = setup_value(property, value);
	return true

func override_value(property, value):
	print("override value ", property, " to ", value)
	var existing = state[property];
	print("Got existing value ", existing)
	if (existing is Reactive):
		if value is Dictionary:
			for key in value:
				existing.set(key, value[key]);
		elif value is Array:
			for i in range(value.size()):
				existing.set(i, value[i]);
		else:
			push_error(str("Cannot set value of type: ", typeof(value), " to reactive value. Trying to set ", property));
	else:
		print("Existing value isn't reactive, overriding value directly");
		state[property] = setup_value(property, value);
	return true

func _get_property_list():
	return properties;
