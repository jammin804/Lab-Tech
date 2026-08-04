extends Node

signal player_spawned(player_ref: Player)
signal enemy_hit_by_projectile(drain_amount: int)
signal wave_completed(current_wave: int)
signal boss_health_changed(new_health: int, max_health: int)
signal screen_shake_requested(intensity: float, duration: float)
signal increase_currency(item_name : String, amount : int)
signal enemy_died
signal pause_auto_actions
signal level_complete
signal show_result_screen(enemies_killed:int, damage_done:int, damage_taken:int, money_earned:int, scraps_earned:int, cores_earned:int, success:String, grade:int)
signal talent_icon_clicked
signal bullet_fired
signal blaster_fully_charged
signal charge_released
signal health_changed
signal max_health_upgraded(new_max)
signal damage_dealt(amount: int)
signal damage_taken(amount: int)

var target_talent_tab : int = 0
