extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()

# TODO Add state queue
var is_actionable = true

export var walk_speed = 96
export var gravity_force = 32
export var jump_force = 640

func _process(delta):
    # Toggle off the previous state
    for child in $States.get_children():
        child.visible = false

    # Crouch
    if Input.is_action_pressed("ui_down"):
        if is_actionable:
            if is_on_floor():
                $States.get_node("CROUCH_0").visible = true
                return

    # Idle
    if is_actionable:
        $States.get_node("IDLE_0").visible = true
        return


func _physics_process(delta):

    # Gravity
    motion.y += gravity_force
    motion = move_and_slide(motion, UP)

    # Left/Right motion
    # TODO check state instead of action pressed
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
