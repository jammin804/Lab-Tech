class_name Money
extends Currency

@export var money : int

func activate():
	super.activate()
	print("+" +  str(money) + "money")
	player_reference.gain_money(money)
