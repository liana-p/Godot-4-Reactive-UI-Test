extends Label

@export var target: Node;
@export var reactivePath: String;
@export var format_string: String;
@export var transform_func: String;

func _ready():
	var transform = null;
	if transform_func:
		transform = transform_func;
	elif format_string:
		transform = Callable(self, 'process_string');
	ReactiveUI.autobind(self, target, reactivePath, 'text', transform);

func process_string(result, bound_target):
	print('process_string', result, bound_target);
	if format_string != null:
		result = format_string % result;
	return result;
