extends Node

signal health_changed(current_health)
signal died

@export var max_health: int = 100

var current_health: int


func _ready():
	current_health = max_health
	health_changed.emit(current_health)


func take_damage(amount: int):
	if current_health <= 0:
		return

	current_health -= amount

	if current_health < 0:
		current_health = 0

	health_changed.emit(current_health)

	print("Vida atual: ", current_health)

	if current_health == 0:
		died.emit()
