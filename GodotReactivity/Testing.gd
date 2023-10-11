extends Node2D

@export var textLabel: Label;
@export var healthBar: ProgressBar;
@export var str_label: Label;
@export var agi_label: Label;
@export var def_label: Label;

var player: Reactive;

func _ready():
	player = Reactive.new({
		'health': 20,
		"name": 'test',
		"stats": {
			"str": 5,
			"agi": 4,
			"def": 3,
		}
	});
	ReactiveUI.bind_label(textLabel, player, 'name');
	ReactiveUI.bind_progress_bar(healthBar, player, 'health');
	ReactiveUI.bind_label(str_label, player.stats, 'str', generate_stat_text);
	ReactiveUI.bind_label(agi_label, player.stats, 'agi', generate_stat_text);
	ReactiveUI.bind_label(def_label, player.stats, 'def', generate_stat_text);
	
func generate_stat_text(value: int, bound: BoundTarget) -> String:
	return str(bound.bound_property, ": ", value);

func hit_player():
	player.health -= 1;

func _on_level_up_pressed():
	player.stats.agi += randi() % 3;
	player.stats.def += randi() % 3;
	player.stats.str += randi() % 3;
