extends Node2D

var player: Reactive;

func _ready():
	# 1. Create a player state
	player = Reactive.new({
		'name': 'Player',
		'health': 30,
		'stats': {
			'str': 5,
			'agi': 5,
			'def': 5,
		},
	});
	pass;
	
	
func generate_stat_text(value: int, bound: BoundTarget) -> String:
	return str(bound.bound_property, ": ", value);

func hit_player():
	player.health -= 1;

func _on_level_up_pressed():
	player.stats.agi += randi() % 3;
	player.stats.def += randi() % 3;
	player.stats.str += randi() % 3;
