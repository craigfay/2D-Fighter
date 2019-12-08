extends KinematicBody2D

var motion = Vector2()

func _physics_process(delta):
    # Gravity
    motion.y += 8

    # Left/Right motion
    if Input.is_action_pressed("ui_left"):
        motion.x = -64
    elif Input.is_action_pressed("ui_right"):
        motion.x = 64
    else:
        motion.x = 0

    move_and_slide(motion)