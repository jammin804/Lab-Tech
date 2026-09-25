extends Node
class_name Global

var current_wave: int = 1
var moving_to_next_wave: bool
var level: int = 0
var total_levels : int = 3
var can_screenshake : bool = true #When damage or upgrade is at a certian level screen shake
var enemies_killed : int = 0
var num_kills_need : int = 350
var num_until_boss : int
