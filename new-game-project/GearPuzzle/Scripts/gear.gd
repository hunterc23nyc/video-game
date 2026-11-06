class_name Gear
extends Area2D

@onready var sprite = $AnimatedSprite2D
var adjacent_spinning_gears: int = 0 # How many adjacent gears are spinning.
@export var driving: bool # If this gear is a driving gear (the one that starts the movement).
@export var unbreakable: bool # If this gear can be destroyed by clicking.
var spinning: bool = false # If this gear is spinning.
var rotation_speed: int = 2 # This gear's rotation speed. Should be the inverse of rotation speeds of adjacent gears.
var selected: bool = false

func _ready():
	add_to_group("gears")
	
	
func _process(delta: float) -> void:
	if (adjacent_spinning_gears > 0 || driving): spinning = true
	if (adjacent_spinning_gears == 0 && !driving): spinning = false
	if (spinning): 
		if (rotation_speed > 0): sprite.play("clockwise")
		else: sprite.play("counterclockwise")
		sprite.rotate(rotation_speed*delta)
	else: sprite.play("idle")
	$SelectionRect.visible = selected
	if (selected):
		if (Input.is_action_just_pressed("delete gear")):
			queue_free()
		if (Input.is_action_just_pressed("rotate gear")):
			rotation_degrees += 90
		if (Input.is_action_just_pressed("escape")):
			selected = false

func refresh():
	if (!driving):
		adjacent_spinning_gears = 0
		for other_gear in get_overlapping_areas():
			if (other_gear.spinning):
				adjacent_spinning_gears += 1
				rotation_speed = -other_gear.rotation_speed

func select():
	selected = true
	
func deselect():
	selected = false
