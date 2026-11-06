extends Control

#load player inv
@onready var inv: Inv = preload("res://inventory/player_inventory.tres")
@onready var grid = $NinePatchRect/GridContainer
var is_open = false
var slot = preload("res://scenes/inv_ui_slot.tscn")
var totalslots: int = 9
func _ready():
	for i in range(totalslots):
		var new_slot = slot.instantiate()
		grid.add_child(new_slot)
	inv.update.connect(update_slots)
	update_slots()
	close()

#update each slot with it corresponding inv slot
func update_slots():
	for i in range(min(inv.slots.size(), grid.get_child_count())):
		print(inv.slots.size())
		grid.get_child(i).update(inv.slots[i])

		#if "i" is press open inv
func _process(delta): 
	if Input.is_action_just_pressed("Inv"):
		if is_open:
			close()
		else:
			open()
		
func open():
	visible = true
	is_open = true
		
func close(): 
	visible = false
	is_open = false

#func _get_drag_data(at_position: Vector2) -> Variant:
	#var preview = TextureRect.new()
	#if "texture" in self:
		#preview = self.texture
	#return self
		#
