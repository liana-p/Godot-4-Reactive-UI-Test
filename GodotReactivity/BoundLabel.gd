extends Label

@export var target: Node;
@export var reactivePath: String;

func _ready():
	ReactiveUI.autobind(self, target, reactivePath, 'text');
