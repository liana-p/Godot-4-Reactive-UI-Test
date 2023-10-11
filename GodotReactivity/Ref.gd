class_name Ref

signal value_changed(value);
var value: get = get_value, set = set_value;

func _init(baseValue):
	self.value = baseValue

func get_value():
	return value

func set_value(newValue):
	self.value = value
	value_changed.emit(newValue)
