extends Panel


@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

#update tiem show item if there is item else no show
func update (slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		print("is item")
		item_visual.visible = true
		if slot.amount > 1:
			"text visible"
			amount_text.visible = true
		amount_text.text = str(slot.amount)
		item_visual.texture = slot.item.texture
		
