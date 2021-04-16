open Types

(* Jumping Constants *)
let gravity = 0.38

let rec level_from_id (levels : Types.level list) str = 
  match levels with 
  | [] -> failwith "No level with id found"
  | h :: t -> if str = h.level_id then h else level_from_id t str

let rec lst_current_keys (lst: (bool * card_dir) list) (acc: card_dir list) = 
  match lst with 
  | [] -> acc 
  | h :: t -> 
    if fst h then
      lst_current_keys t (snd h :: acc) else
      lst_current_keys t acc

(**[get_key_press] adds the keys pressed into a tuple list so we can 
   process two directions of motions at once (e.g. moving up and right 
   at the same time *)
let get_key_press () =
  let keys_assoc_lst =
    [(player_command.left, West);
     (player_command.right, East); 
     (player_command.up, North);
     (player_command.down, South)] in
  let dir_list = lst_current_keys (List.rev keys_assoc_lst) [] in dir_list

(**[match_key_to_player command state key] updates the player's location based
   on the key pressed.
   Left pressed: West; Right pressed: East; Up pressed: North; 
   Down pressed: South *)
let rec match_key_to_player command state (sprite : sprite) key = 
  let old_x, old_y = sprite.coordinate in 
  match key with 
  | East -> 
    let new_x = old_x +. sprite.speed in let new_y = old_y in 
    sprite.coordinate <- (new_x, new_y);
    sprite.direction <- Right;
  | West ->
    let new_x = max 0. (old_x +. (-1. *. sprite.speed)) in let new_y = old_y in 
    sprite.coordinate <- (new_x, new_y); 
    sprite.direction <- Left
  | North ->
    if sprite.jumping = false && sprite.grounded = true then begin 
      sprite.jumping <- true; sprite.grounded <- false;
      let jump_height = 8.5 in 
      let possible = sprite.new_jump.y -.
                     (jump_height +. abs_float sprite.new_jump.x *. 0.5) in 
      let max_jump = -9.0 in 
      sprite.new_jump.y <- max possible max_jump end; 
  | South -> ()

(**[s_center sprite] returns the location of the center of the [sprite] with 
   respect to its location. *)
let s_center (sprite : sprite) =
  let (box, boy) = sprite.coordinate in 
  let (sx, sy) = sprite.size in
  let new_x = box +. sx /. 2.0 in 
  let new_y = boy +. sy /. 2.0 in
  (new_x, new_y)

(**[s_half sprite] returns half the width,hieght of the [sprite] *)
let s_half (sprite : sprite) =
  let (sx, sy) = sprite.size in
  let new_x =  sx /. 2.0 in 
  let new_y =  sy /. 2.0 in
  (new_x, new_y)

let get_lvl_aspect (aspect : aspect) = 
  match aspect with 
  | GSpikes g | G3Spikes g | RGSpikes g | LSpikes g | RSpikes g 
  | Cloud g | SingleBrick  g | Ground g 
  | Hole g | PartialGround g -> g

(**[o_half aspect] is half of the size of [aspect]. *)
let o_half aspect =
  let lvl_aspect = get_lvl_aspect aspect in 
  let half_w = lvl_aspect.width /. 2.0 in 
  let half_h = lvl_aspect.height /. 2.0 in 
  (half_w, half_h)

(**[o_center aspect] returns the location of the center of the [aspect] with 
   respect to its location.*)
let o_center (aspect : aspect) =
  let lvl_aspect = get_lvl_aspect aspect in 
  let (half_w, half_h) = o_half aspect in
  let new_x = lvl_aspect.x_pos +. half_w in 
  let new_y = lvl_aspect.y_pos +. half_h in 
  (new_x, new_y)

(**[o_half aspect] returns half the width,hieght of the [aspect]*)
let o_half aspect =
  let lvl_aspect = get_lvl_aspect aspect in 
  let new_x = lvl_aspect.width /. 2.0 in 
  let new_y = lvl_aspect.height /. 2.0 in 
  (new_x, new_y)

(**[pw_center pw] returns the location of the center of the [pw] with 
   respect to its location.*)
let pw_center (pw : power_up) =
  let x_pos, y_pos = pw.pcoordinate in
  let new_x = x_pos +. pw.pwidth /. 2.0 in 
  let new_y = y_pos +. pw.pheight /. 2.0 in 
  (new_x, new_y)

(**[pw_half pw] returns half the width,hieght of the [pw]*)
let pw_half (pw : power_up) =
  let new_x = pw.pwidth /. 2.0 in 
  let new_y = pw.pheight /. 2.0 in 
  (new_x, new_y)

(**[dir_with_y diff_in_y y_dir] returns North or South depending on whether
   [diff_in_y] is negative or not. A helper function for collisions. *)
let dir_with_y diff_in_y y_dir (player : sprite) =
  let old_x,old_y = player.coordinate in
  if diff_in_y > 0. then begin 
    player.coordinate <- (old_x, (old_y +. y_dir));  
    Some North
  end
  else begin 
    player.coordinate <- (old_x,(old_y -. y_dir));  
    Some South
  end

(**[dir_with_x diff_in_x x_dir] returns East or West depending on whether
   [diff_in_x] is negative or not. A helper function for collisions. *)
let dir_with_x diff_in_x x_dir (player : sprite) = 
  let old_x,old_y = player.coordinate in
  if diff_in_x > 0. then begin  
    player.coordinate <- ((old_x +.x_dir), old_y); 
    Some West
  end
  else begin 
    player.coordinate <- ((old_x -. x_dir), old_y); 
    Some East
  end

let op_on_both tup1 tup2 op =
  let first = op (fst tup1) (fst tup2) in 
  let second = op (snd tup1) (snd tup2) in
  (first, second) 

let check_aspect_collision (sprite : sprite) aspect  =
  let sprite_center = s_center sprite in 
  let sprite_half = s_half sprite in 
  let asp_center = o_center aspect in
  let asp_half =  o_half aspect in 
  let diff_in_x, diff_in_y = op_on_both sprite_center asp_center (-.) in 
  let half_w, half_h = op_on_both sprite_half asp_half (+.) in
  let abs_diff_in_x = abs_float diff_in_x in 
  let abs_diff_in_y = abs_float diff_in_y in 
  if abs_diff_in_x  < half_w && abs_diff_in_y < half_h then begin
    let x_dir = half_w -. abs_diff_in_x in
    let y_dir = half_h -. abs_diff_in_y in
    if x_dir > y_dir then dir_with_y diff_in_y y_dir sprite else 
      dir_with_x diff_in_x x_dir sprite 
  end 
  else None

(**[collide_aspect dir sprite v] edits [sprite] attributes based on [dir] after 
   it  collides with an aspect. *)
let collide_aspect dir sprite v =
  match dir with
  | North -> 
    sprite.new_jump.y <- 0.
  | South -> begin
      sprite.ground_loc <- v;
      sprite.new_jump.y <- 0.;
      sprite.grounded <- true;
      sprite.jumping <- false
    end;
  | East | West -> sprite.new_jump.x <- 0. 

(**[process_aspect_collision dir sprite aspect] updates the [sprite] based on
   the [dir] that it collides with the [aspect].  *)
let process_aspect_collision dir (sprite : sprite) aspect =
  match aspect, dir with
  | Ground g, _ | PartialGround g, _->
    collide_aspect dir sprite 
      (g.y_pos -. snd(sprite.size) -. 1.); ()
  | SingleBrick sb, _ -> 
    collide_aspect dir sprite 
      (sb.y_pos -. snd(sprite.size) -. 1.); ()
  | GSpikes s, _ | RGSpikes s, _ | LSpikes s, _ 
  | RSpikes s, _ | G3Spikes s, _  | Cloud s, _  -> 
    sprite.health <- sprite.health - 1;
    sprite.send_back <- true;
  | _ -> ()

(**[on_platform sprite aspect] updates the grounded attribute of [sprite] based
   on it's location relative to [aspect]. *)
let on_platform (sprite : sprite) (aspect : aspect) = 
  let on_stable sb sprite = begin
    let x, y = sprite.coordinate in 
    let w, h = sprite.size in 
    if (sb.x_pos +. sb.width < x && x < sb.x_pos +. sb.width +. w +. 1. 
        && sb.e_blocked = None || 
        sb.x_pos -. w -. 1. > x && x > sb.x_pos -. w -. w -. 1.
        && sb.w_blocked = None) && 
       (y < sb.y_pos)
    then sprite.grounded <- false; end in
  if not sprite.grounded then () else
    match aspect with
    | SingleBrick sb | PartialGround sb -> 
      on_stable sb sprite
    | _ -> ()

(**[player_aspect_state command state sprite] checks for collisions between 
   [sprite] and each aspect of the aspect list of [state]. *)
let rec player_aspect_state command state (sprite : sprite) =
  let rec process_asp_st_helper command aspectlist (sprite : sprite) acc = 
    match aspectlist with 
    | [] -> ()
    | h :: t ->
      begin match check_aspect_collision sprite h with
        | None -> 
          on_platform sprite h;
          process_asp_st_helper command t sprite acc
        | Some dir -> 
          begin 
            process_aspect_collision dir sprite h;
            process_asp_st_helper command t sprite acc  
          end 
      end
  in let curr_level = level_from_id state.levels state.level in
  process_asp_st_helper command (curr_level.asp_list) sprite []

(**[update_player command state sprite] updates the location of [sprite] 
   based on the key press of the player *)
let update_player_movement command state (sprite : sprite) = 
  let keys = get_key_press () in 
  List.iter (match_key_to_player command state sprite) keys; 
  if (sprite.grounded ) then sprite.new_jump.y <- 0. else 
    begin
      let max_y_vel = 4.5 in 
      let possible_y = sprite.new_jump.y +. gravity in 
      sprite.new_jump.y <- min possible_y max_y_vel
    end;
  player_aspect_state command state sprite;
  let old_x, old_y = sprite.coordinate in
  let max_y = max (sprite.new_jump.y +. old_y) 0. in
  if not sprite.send_back then 
    sprite.coordinate <- ((old_x), (max_y))
  else begin
    sprite.coordinate <- (15., 494.);
    sprite.jumping <- false;
    sprite.grounded <- true;
    sprite.send_back <- false 
  end 

let update_enemy_location (sprite : sprite) state =
  if sprite.send_back then begin 
    let curr_loc = sprite.coordinate in 
    let target_loc = (750., snd curr_loc) in
    {sprite with coordinate = target_loc} end else 
    let int_sprite = sprite in
    let curr_loc = sprite.coordinate in 
    let new_x = 
      if fst curr_loc > -500. 
      then fst curr_loc +. sprite.speed *. -1. 
      else 800. in 
    let target_loc = (new_x , snd curr_loc) in 
    {int_sprite with coordinate = target_loc}

let update_action command (sprite : sprite) = 
  if command.up then Jumping 
  else if command.down then Crouching 
  else if command.left || command.right then Running
  else Standing

(**[update_player state sprite] updates the player [sprite]*)
let update_player state (sprite : sprite) = 
  let sprite_health = sprite.health in 
  update_player_movement player_command state sprite; 
  if snd (sprite.coordinate) > 560. then  
    {sprite with action = update_action player_command sprite; 
                 health = sprite_health - 1} 
  else {sprite with action = update_action player_command sprite}

(**[update_enemy state sprite] updates a single enemy [sprite]*)
let update_enemy state (sprite : sprite) =
  {(update_enemy_location sprite state) with
   send_back = false}

let check_sprite_collision player enemy =
  let player_center = s_center player in 
  let player_half = s_half player in 
  let enemy_center = s_center enemy in
  let enemy_half =  s_half enemy in 
  let diff_in_x, diff_in_y = op_on_both player_center enemy_center (-.) in 
  let half_w, half_h = op_on_both player_half enemy_half (+.) in
  let abs_diff_in_x = abs_float diff_in_x in 
  let abs_diff_in_y = abs_float diff_in_y in 
  if abs_diff_in_x < half_w && abs_diff_in_y < half_h then begin
    let x_dir = half_w -. abs_diff_in_x in
    let y_dir = half_h -. abs_diff_in_y in
    if x_dir >= y_dir then dir_with_y diff_in_y y_dir player else 
      dir_with_x diff_in_x x_dir player 
  end else None

let alive_after_collision dir player enemy state =
  match dir with
  | South ->
    begin 
      state.score <- state.score + 100; 
      false
    end 
  | North | East | West -> 
    player.health <- player.health - 1;
    player.send_back <- true;
    enemy.send_back <- true;
    true

(**[enemy_collision enemy_list state sprite] checks for collisions between 
   [sprite] and each enemies of [enemy_list] of [state]. *)
let rec enemy_collision enemy_list state (sprite : sprite) =
  let rec helper (enemy_list : Types.sprite list) (sprite : sprite) acc = 
    match enemy_list with
    | [] -> acc
    | h :: t ->
      begin 
        match check_sprite_collision sprite h with 
        | None -> helper t sprite (h :: acc)
        | Some dir ->
          if not (alive_after_collision dir sprite h state) then
            helper t sprite acc else 
            helper t sprite (h :: acc)
      end 
  in helper enemy_list sprite []

(**[update_enemies state sprite] checks for collisions between 
   [sprite] and each enemies of [enemy_list] of [state] and updates the
   location of all the sprites. A helper function of update_state. *)
let update_enemies state sprite = 
  let enemy_list = 
    match state.sprites with
    | [] -> failwith "no player"
    | h :: [] -> []
    | h :: t -> t
  in
  let new_enemy_list = enemy_collision enemy_list state sprite in
  List.map (update_enemy state) (new_enemy_list)

(**[check_pw_collision player powerup] checks if there is a collision between 
   the [player] and the [powerup] and returns the option direction, 
   else None. *)
let check_pw_collision player powerup =
  let player_center = s_center player in 
  let player_half = s_half player in 
  let powerup_center = pw_center powerup in
  let powerup_half =  pw_half powerup in 
  let diff_in_x, diff_in_y = op_on_both player_center powerup_center (-.) in 
  let half_w, half_h = op_on_both player_half powerup_half (+.) in
  let abs_diff_in_x = abs_float diff_in_x in 
  let abs_diff_in_y = abs_float diff_in_y in 
  if abs_diff_in_x < half_w && abs_diff_in_y < half_h then begin
    let x_dir = half_w -. abs_diff_in_x in
    let y_dir = half_h -. abs_diff_in_y in
    if x_dir >= y_dir then dir_with_y diff_in_y y_dir player else 
      dir_with_x diff_in_x x_dir player 
  end else None

(**[process_pw_collision player powerup state] updates the [player] based on
   what [powerup] it collided with.  *)
let process_pw_collision player powerup state =
  match powerup with
  | ExtraLife _ -> 
    player.health <- player.health + 1;
  | _ -> ()

(**[update_power_ups state sprite] checks for collisions between 
   [sprite] and each powerups of the current level in [state]. A helper 
   function of update_state. *)
let update_power_ups state sprite = 
  let filter_pw pw = begin
    match pw with 
    | None -> false
    | ExtraLife p -> 
      let did_collide = check_pw_collision sprite p <> None in
      if did_collide then process_pw_collision sprite pw state;
      not did_collide
  end in 
  let curr_level = level_from_id state.levels state.level in 
  let new_pw = List.filter filter_pw curr_level.powerup_list in
  {curr_level with powerup_list = new_pw}

let rec next_level_id (lst : Types.level list) (curr : string) = 
  match lst with 
  | [] -> failwith "No next level - violated precondition"
  | h :: t -> if curr = h.level_id then (List.hd t).level_id 
    else next_level_id t curr

let next_stage state (sprite : sprite) = 
  let last_level = List.hd (List.rev state.levels) in 
  if last_level.level_id = state.level then
    state.level
  else if fst(sprite.coordinate) < 750. then
    state.level else
    next_level_id state.levels state.level 

let reset_sprite health (sprite_list : Types.sprite list) x_val y_val = 
  let sprite = List.hd sprite_list in 
  let new_loc = (x_val, y_val) in
  let new_sprite = {sprite with coordinate = new_loc; 
                                health = max 3 health;
                                level_change = true} in  
  let new_list = new_sprite :: (List.tl sprite_list) 
  in new_list 

let update_health state sprite = 
  if sprite.health = 0 then {state with has_lost = true } else state

let next_stage_state state (sprite : sprite) = 
  let last_level = List.hd (List.rev state.levels) in 
  if last_level.level_id = state.level && 
     fst(sprite.coordinate) > 600. then 
    {state with has_won = true}
  else if last_level.level_id = state.level then state
  else if fst(sprite.coordinate) >= 730. && sprite.level_change = false 
  then begin  
    let next_lvl_id = next_level_id state.levels state.level in
    let next_lvl = level_from_id state.levels next_lvl_id in
    let sprites_reset = reset_sprite sprite.health next_lvl.sprite_list 
        15. 494. in {state with level = next_lvl_id; 
                                sprites = sprites_reset}
  end 
  else {state with 
        sprites = {(List.hd state.sprites) with 
                   level_change = false} :: List.tl state.sprites}

(**[get_next_state state sprite] is the [state] that is returned based on 
   whether [sprite] has no health or has reached the end of a stage *)
let get_next_state state sprite = 
  if sprite.health = 0 then update_health state sprite 
  else next_stage_state state sprite 

let all_but_current current new_current_level level  =
  if level.level_id = current then new_current_level else level

let update_state state = 
  let next_player_sprite = 
    (update_player state (List.hd state.sprites)) in 
  let next_enemy_sprites = update_enemies state next_player_sprite in 
  let new_current_level = update_power_ups state next_player_sprite in
  let new_level_list =  List.map (all_but_current state.level 
                                    new_current_level) state.levels in 
  let new_state = 
    {state with sprites = next_player_sprite :: next_enemy_sprites;
                levels = new_level_list} in

  get_next_state new_state next_player_sprite