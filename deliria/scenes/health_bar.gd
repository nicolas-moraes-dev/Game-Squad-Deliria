extends ProgressBar

@onready var health = get_node("../../Player/Health")

func _ready():
	max_value = health.max_health
	value = health.current_health
	health.health_changed.connect(_on_health_changed)

func _on_health_changed(current_health):
	value = current_health
