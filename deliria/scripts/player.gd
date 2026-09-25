extends CharacterBody2D

@export var speed: float = 200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health = $Health

var last_direction := Vector2.DOWN

func _ready():
	health.died.connect(_on_died)

func _physics_process(_delta):
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = direction * speed

	move_and_slide()

	update_animation(direction)

func update_animation(direction: Vector2):
	if direction != Vector2.ZERO:
		last_direction = direction

		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animated_sprite.play("run_right")
			else:
				animated_sprite.play("run_left")
		else:
			if direction.y > 0:
				animated_sprite.play("run_down")
			else:
				animated_sprite.play("run_up")

	else:
		if abs(last_direction.x) > abs(last_direction.y):
			if last_direction.x > 0:
				animated_sprite.play("idle_right")
			else:
				animated_sprite.play("idle_left")
		else:
			if last_direction.y > 0:
				animated_sprite.play("idle_down")
			else:
				animated_sprite.play("idle_up")

func take_damage(amount: int):
	health.take_damage(amount)

func _on_died():
	print("O jogador morreu!")
	get_tree().reload_current_scene()
