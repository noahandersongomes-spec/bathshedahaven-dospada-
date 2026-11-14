class_name CoinHUD
extends CanvasLayer

@onready var _label: Label = $Label

func _process(_delta: float) -> void:
	_label.text = "Coins: %d" % Coin.count