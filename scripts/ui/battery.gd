extends Control
class_name Battery

@export var back_bar: TextureProgressBar
@export var front_bar: TextureProgressBar

@export var back_bar2: TextureProgressBar
@export var front_bar2: TextureProgressBar

@export var back_bar3: TextureProgressBar
@export var front_bar3: TextureProgressBar

@export var player: Player

var health_tween : Tween
var health_tween2 : Tween
var health_tween3 : Tween


func _ready() -> void:
	
	Events.player_spawned.connect(_on_player_spawned)
	Events.enemy_hit_by_projectile.connect(_on_enemy_hit)
	
	if front_bar2: front_bar2.hide()
	if back_bar2: back_bar2.hide()
	
	if front_bar3: front_bar3.hide()
	if back_bar3: back_bar3.hide()
	
	
	
	var active_players = get_tree().get_nodes_in_group("player")
	
	if active_players.size() > 0:
		print("UI found player via fallback group!")
		_on_player_spawned(active_players[0])
		
func update_hpbar_animated():
	var tank_cap: float = PlayerManager.current_stats.battery_tank_points
	if not player:
		return
		
	# --- TIER 1 MATH (0 to 200 HP) ---
	var tier_1_current = clamp(player.current_health, 0, tank_cap)
	var bar_1_percent = (tier_1_current * 100) / tank_cap
	
	front_bar.value = bar_1_percent
	animate_back_bar(back_bar, health_tween, bar_1_percent)
	
	# --- TIER 2 MATH (200 to 400 HP) ---
	if player.max_health > tank_cap:
		if front_bar2: front_bar2.show()
		if back_bar2: back_bar2.show()
		
		var tier_2_current = clamp(player.current_health - tank_cap, 0, tank_cap)
		
		var bar_2_percent = (tier_2_current * 100) / tank_cap
		
		if front_bar2: 
			front_bar2.value = bar_2_percent
		if back_bar2: 
			animate_back_bar2(back_bar2, health_tween2, bar_2_percent)
			

#FIXME: Math Bug for the 3rd battery upgrade for max health
#region Math Bug for the 3rd battery upgrade for max health
	 #--- TIER 3 MATH (above 600 HP) --- Fix this bug
	if player.max_health > tank_cap * 2:
		if front_bar3: front_bar3.show()
		if back_bar3: back_bar3.show()
		
		var tier_3_current = clamp(player.current_health - tank_cap * 2, 0, tank_cap)
		
		var bar_3_percent = (tier_3_current * 100) / tank_cap
		
		if front_bar3: 
			front_bar3.value = bar_3_percent
		if back_bar3: 
			animate_back_bar3(back_bar3, health_tween3, bar_3_percent)
			
		print("From battery -> update_hpbar_animated for tier 3 batter: " + str(player.current_health))
#endregion

func _on_player_spawned(player_ref: Player) -> void:
	
	print("SUCCESS: UI detected that " + player_ref.name + " has spawned!")
	player = player_ref
	#print("From Battyer -> _on_player_spawned" : str(player.max_health))
	player.health_changed.connect(update_hpbar_animated)
	update_hpbar_animated()
	
func _on_enemy_hit(drain_amount: int) -> void:
	if not player:
		return
		
	player.current_health += drain_amount
	player.current_health = clamp(player.current_health, 0, player.max_health)
	
	update_hpbar_animated()


func animate_back_bar(target_bar:TextureProgressBar, tween_ref: Tween, target_value:float) -> void:
	if not target_bar:
		return
	
	if tween_ref and tween_ref.is_valid():
		tween_ref.kill()
		
	tween_ref = create_tween()
	tween_ref.tween_interval(0.4)
	tween_ref.tween_property(target_bar, "value", target_value, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func animate_back_bar2(target_bar:TextureProgressBar, tween_ref: Tween, target_value:float) -> void:
	if not target_bar:
		return
	
	if tween_ref and tween_ref.is_valid():
		tween_ref.kill()
		
	tween_ref = create_tween()
	tween_ref.tween_interval(0.4)
	tween_ref.tween_property(target_bar, "value", target_value, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func animate_back_bar3(target_bar:TextureProgressBar, tween_ref: Tween, target_value:float) -> void:
	if not target_bar:
		return
	
	if tween_ref and tween_ref.is_valid():
		tween_ref.kill()
		
	tween_ref = create_tween()
	tween_ref.tween_interval(0.4)
	tween_ref.tween_property(target_bar, "value", target_value, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
