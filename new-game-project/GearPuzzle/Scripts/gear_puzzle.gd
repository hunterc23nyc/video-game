extends Node2D

var gear_scene = preload("res://GearPuzzle/Scenes/gear.tscn")
var gear_size = 64
var offset = 32
@onready var gears = $Gears
@onready var blocks = $Blocks
var drag_start = 0 # Identifies what the action was when dragging started. 0 = null, 1 = place, 2 = select
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("place gear")):
		get_tree().call_group("gears", "deselect")
		place_gear()
	elif (Input.is_action_pressed("place gear")):
		drag_place_gear()
	if (Input.is_action_just_released("place gear")): drag_start = 0
	for gear in gears.get_children():
		gear.refresh()

func place_gear():
	var gearPos = get_local_mouse_position()
	gearPos.x = gearPos.x - (int(gearPos.x) % gear_size) + offset
	gearPos.y = gearPos.y - (int(gearPos.y) % gear_size) + offset
	var gear = gear_scene.instantiate()
	gear.global_position = gearPos
	var overlap = false
	for block in blocks.get_children(): # If attempting to place on a block, don't place
		if (block.global_position == gearPos):
			overlap = true
	for other_gear in gears.get_children(): # If attempting to place on another gear, don't place
		if (other_gear.global_position == gearPos): 
			overlap = true
			if (!other_gear.unbreakable): 
				other_gear.select() # If the other gear is breakable, select it
				drag_start = 2
			
	if (!overlap): 
		gears.add_child(gear) # If placing a gear
		get_tree().call_group("gears", "deselect")
		drag_start = 1
		
func drag_place_gear():
	var gearPos = get_local_mouse_position()
	gearPos.x = gearPos.x - (int(gearPos.x) % gear_size) + offset
	gearPos.y = gearPos.y - (int(gearPos.y) % gear_size) + offset
	var gear = gear_scene.instantiate()
	gear.global_position = gearPos
	if (drag_start == 1):
		var overlap = false
		for block in blocks.get_children(): # If attempting to place on a block, don't place
			if (block.global_position == gearPos):
				overlap = true
		for other_gear in gears.get_children(): # If attempting to place on another gear, don't place
			if (other_gear.global_position == gearPos): 
				overlap = true
				break
		if (!overlap): 
			gears.add_child(gear) # If placing a gear
	elif (drag_start == 2):
		for other_gear in gears.get_children(): # If attempting to place on another gear, don't place
			if (other_gear.global_position == gearPos): 
				other_gear.select()
