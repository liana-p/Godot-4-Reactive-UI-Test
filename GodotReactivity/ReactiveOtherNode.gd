extends Node

@export var element: Node;
@export var target: Node;
@export var bound_property: String;
@export var reactivePath: String;
@export var transform_func: String;

func _ready():
  ReactiveUI.autobind(element, target, reactivePath, bound_property, transform_func);
