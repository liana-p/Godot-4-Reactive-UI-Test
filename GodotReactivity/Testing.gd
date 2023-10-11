extends Node2D

var player = {
	'health': 20,
	"name": 'test',
	"stats": {
		"str": 5,
		"agi": 4,
	}
}

func _ready():
	player.health = 5;
	print(player);
