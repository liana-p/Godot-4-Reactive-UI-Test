extends Reactive

class_name DataStore

func v(path: String) -> Reactive:
	var keys := path_to_keys(path);
	var result = self;
	for key in keys:
		result = result.state[key];
	return result;

func path_to_keys(path: String) -> PackedStringArray:
	return path.split(".");

static func make_reactive(initialState: Dictionary) -> Reactive:
	var reactive = Reactive.new({});
	for key in initialState.keys():
		if initialState[key] is Dictionary:
			reactive.state[key] = make_reactive(initialState[key]);
		else:
			reactive.state[key] = Reactive.new(initialState[key]);
	return reactive;
  
