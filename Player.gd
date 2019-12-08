extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

func _physics_process(delta):
    # Gravity
    motion.y += 16
    motion = move_and_slide(motion, UP)

    # Left/Right motion
    if Input.is_action_pressed("ui_left"):
        motion.x = -96
    elif Input.is_action_pressed("ui_right"):
        motion.x = 96
    else:
        motion.x = 0

    if is_on_floor():
        if Input.is_action_just_pressed("ui_up"):
            motion.y = -320
