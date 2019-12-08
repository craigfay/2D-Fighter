extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

var walk_speed = 96
var gravity_force = 16
var jump_force = 320

func _physics_process(delta):
    # Gravity
    motion.y += gravity_force
    motion = move_and_slide(motion, UP)

    # Left/Right motion
    if Input.is_action_pressed("ui_left"):
        motion.x = -walk_speed
    elif Input.is_action_pressed("ui_right"):
        motion.x = walk_speed
    else:
        motion.x = 0

    # Jump
    if is_on_floor():
        if Input.is_action_just_pressed("ui_up"):
            motion.y = -jump_force
