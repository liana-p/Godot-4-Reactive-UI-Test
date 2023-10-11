extends ProgressBar

@export var target: Node;
@export var reactivePath: String;
@export var transform_func: String;

func _ready():
  ReactiveUI.autobind(self, target, reactivePath, 'value', transform_func);
