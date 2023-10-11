class_name BoundTarget

var target;
var bound_property: String;
var target_property: String;
var transform_func;

func _init(target, bound_property, target_property, transform_func = null):
  self.target = target;
  self.bound_property = bound_property;
  self.target_property = target_property;
  self.transform_func = transform_func;