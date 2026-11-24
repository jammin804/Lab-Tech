class_name TerminatorEnemy
extends Enemy

func move_enemy(_delta):
	if enemy_type == ENEMY_TYPE.TERMINATOR:
		print("Stop and fire after a few sections")
