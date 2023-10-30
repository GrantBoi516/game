extends CharacterBody2D


@export var speed = 5.0
@onready var weapon = $weapon


func _physics_process(delta):
	movement(velocity)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):#attack action
		weapon.attack()


func movement(v):#player inputs for movement
	if Input.is_action_pressed("ui_right"):
		v.x += 1
	if Input.is_action_pressed("ui_left"):
		v.x -= 1
	if Input.is_action_pressed("ui_down"):
		v.y += 1
	if Input.is_action_pressed("ui_up"):
		v.y -= 1
	v = v.normalized()
	if v == Vector2.ZERO:
		$PlayerAnim/AnimTree.get("parameters/playback").travel("Idle")
	else:
		$PlayerAnim/AnimTree.get("parameters/playback").travel("Walk")
		$PlayerAnim/AnimTree.set("parameters/Idle/blend_position", v)
		$PlayerAnim/AnimTree.set("parameters/Walk/blend_position", v)
	move_and_collide(v * speed)
	return v