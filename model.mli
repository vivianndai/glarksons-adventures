(**Controls the state of game execution *)
open Types

(**[gravity] is a constant to control the y-values of a player jump*)
val gravity : float

(**[update_state state] updates the [state] of the game *)
val update_state : state -> state

(**[update_health state sprite] is a state with has_lost attribute set to
   true if the player runs out of lives *)
val update_health : state -> sprite -> state

(**[next_stage state sprite] is the level_id the player is on. It changes
   only when the player reaches the right edge of the playing screen *)
val next_stage : Types.state -> Types.sprite -> string

(**[next_stage_state state sprite] is the updated [state]. [state] is 
   changed with [has_won] if the [sprite] reaches the right edge of the last
   level. On any other level, [state] is updated with the player at the 
   beginning of the next level. If the player is not at the right edge, 
   [state] is returned.*)
val next_stage_state : state -> sprite -> state

(**[alive_after_collision dir player enemy] determines if the [player] is alive
   or dead after collision with [enemy] based on the [dir]. Updates the player 
   and enemy sprites accordingly. *)
val alive_after_collision : 
  Types.card_dir -> Types.sprite -> Types.sprite -> Types.state -> bool

(**[enemy_collision enemy_list state sprite] checks for collisions between 
   [sprite] and each enemies of [enemy_list] of [state]. *)
val enemy_collision : 
  Types.sprite list -> Types.state -> Types.sprite -> Types.sprite list

(**[update_action command sprite] updates the [sprite] action based on the
   key pressed*)
val update_action : Types.command -> Types.sprite -> Types.movements

(**[all_but_current current new_current_level level] is [new_current_level] if
   the id of [level] = [current]. Else, it is [level] *)
val all_but_current : string -> Types.level -> Types.level -> Types.level

(**[reset_sprite spritelst x_val y_val] is an updated spritelst with the player
   sprite at location ([x_val],[y_val])*)
val reset_sprite :
  int -> Types.sprite list -> float -> float -> Types.sprite list

(**[op_on_both tup1 tub2] returns a tuple by performing [op] on the first and 
   second parts of both [tup1] and [tup2] *)
val op_on_both : 'a * 'a -> 'b * 'b -> ('a -> 'b -> 'c) -> 'c * 'c

(**[level_from_id levellst id] is the level cooresponding to [id] in 
   [levellst] *)
val level_from_id : Types.level list -> string -> Types.level

(**[lst_current_keys lst acc] is the list of keys currently being pressed*)
val lst_current_keys : (bool * Types.card_dir) list -> Types.card_dir list 
  -> Types.card_dir list

(**[next_level_id levellst id] is the id of the level after the level with 
   id [curr]. 
   Requires: [curr] is not the id of the last level *)
val next_level_id : Types.level list -> string -> string

(**[get_lvl_aspect aspect] is the level aspect_info associated with [aspect] *)
val get_lvl_aspect : Types.aspect -> Types.aspect_info

(**[update_enemy_location sprite state] updates the location of [sprite]*)
val update_enemy_location : Types.sprite -> Types.state -> Types.sprite

(**[check_aspect_collision sprite aspect] checks if there is a collision between 
   the [sprite] and the [aspect] and returns the option direction, else None. *)
val check_aspect_collision : Types.sprite -> Types.aspect -> 
  Types.card_dir option 

(**[check_pw_collision player powerup] checks if there is a collision between 
   the [player] and the [powerup] and returns the option direction, 
   else None. *)
val check_pw_collision : Types.sprite -> Types.power_up 
  -> Types.card_dir option 

(**[check_sprite_collision player enemy] checks if there is a collision between 
   the [player] and the [enemy] and returns the option direction, else None. *)
val check_sprite_collision : Types.sprite -> Types.sprite 
  -> Types.card_dir option
