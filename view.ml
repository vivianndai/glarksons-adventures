open Js_of_ocaml
open Types
open Levels
open Model

module Html = Dom_html
let js = Js.string
let document = Dom_html.document

(**Constant for canvas width*)
let canvas_width = 755.

(**Constant for canvas height*)
let canvas_height = 600.

let win_screen (context: Html.canvasRenderingContext2D Js.t) =
  context##.fillStyle := js "black"; 
  context##fillRect 0. 0. canvas_width canvas_height;
  context##.fillStyle := js "white";
  context##.font := js "30px Arcade";
  context##.textAlign := js "center";
  context##fillText (js "YOU WIN!") (canvas_width/.2.) (canvas_height/.2.) ;
  context##fillText (js "Refresh  to   play  again")
    (canvas_width/.2.) (canvas_height/.2. +. 50.)

let lose_screen (context: Html.canvasRenderingContext2D Js.t) =
  context##.fillStyle := js "black";
  context##fillRect 0. 0. canvas_width canvas_height;
  context##.fillStyle := js "white";
  context##.font := js "30px Arcade";
  context##.textAlign := js "center";
  context##fillText (js "GAME OVER") (canvas_width/.2.) (canvas_height/.2.); 
  context##fillText (js "Refresh  to  play  again")
    (canvas_width/.2.) (canvas_height/.2. +. 50.)

let clear (context: Html.canvasRenderingContext2D Js.t) =
  context##clearRect 0. 0. canvas_width canvas_height

let update_enemy_img enemy_type (sprite : sprite) =
  match enemy_type with
  | Robot ->
    {sprite with 
     image_size = (32., 62.);
     offset = (0., 0.);
    }
  | Camels ->
    {sprite with 
     image_size = (98., 84.);
     offset = (0., 0.)};
  | CompMouse ->
    {sprite with 
     image_size = (62., 24.);
     offset = (0., 0.);}

(**[update_face_right sprite] updates the sprites image on spritesheet if
   it is facing right. *)
let update_face_right sprite =
  match sprite.action with
  | Standing -> begin
      sprite.offset <- (0., 0.);
      sprite.num_images <- 1;
      sprite.num_frames <- 60;
    end
  | Jumping -> begin
      sprite.offset <- (0., 188.);
      sprite.num_images <- 1;
      sprite.num_frames <- 60;
    end
  | Running -> begin
      sprite.offset <- (0., 0.);
      sprite.num_images <- 3;
      sprite.num_frames <- 5;
    end
  | _ -> begin
      sprite.offset <- (0., 188.);
      sprite.num_images <- 1;
      sprite.num_frames <- 60;
    end

(**[update_face_right sprite] updates the sprites image on spritesheet if
   it is facing left. *)
let update_face_left sprite =
  match sprite.action with
  | Standing -> begin
      sprite.offset <- (0., 47.);
      sprite.num_images <- 1;
      sprite.num_frames <- 60;
    end
  | Jumping -> begin
      sprite.offset <- (23., 188.);
      sprite.num_images <- 1;
      sprite.num_frames <- 60;
    end
  | Running -> begin
      sprite.offset <- (0., 47.);
      sprite.num_images <- 3;
      sprite.num_frames <- 5;
    end
  | _ -> begin
      sprite.offset <- (23., 188.);
      sprite.num_images <- 1;
      sprite.num_frames <- 60;
    end

let update_sprite_img sprite = 
  match sprite.direction with
  | Right -> update_face_right sprite
  | Left -> update_face_left sprite

let get_level_aspects ascept_list =
  List.map 
    (fun aspect ->  
       match aspect with 
       | Ground a | GSpikes a | SingleBrick a | Hole a | RGSpikes a 
       | LSpikes a | RSpikes a | G3Spikes a | Cloud a
       | PartialGround a -> a ) 
    ascept_list

(**[draw_image context img_src coord] draws the image based on [img_src] 
   on [context] at [coord] *)
let draw_image (context: Html.canvasRenderingContext2D Js.t) img_src coord =
  let img = Html.createImg document in
  img##.src := img_src;
  context##drawImage (img) (fst coord) (snd coord)

(**[draw_aspect context aspectlist] draws each element of [aspectlist] onto 
   [context]*)
let draw_aspect context (aspectlist : aspect list) = 
  let level_aspects = get_level_aspects aspectlist in
  List.map 
    (fun aspect -> draw_image context (js aspect.image) (aspect.x_pos, 
                                                         aspect.y_pos)) 
    level_aspects |> ignore

(**[draw_health context sprite] draws the health of [sprite] onto [context].
   1 health corresponds to 1 heart on [context]*)
let draw_health context sprite = 
  let rec draw_heart context acc =
    if acc = 0 then () else begin
      draw_image context (js "images/Heart.png") 
        (100. +. 22. *. (float_of_int acc), 20.);
      context##.fillStyle := js "white";
      context##.font := js "20px Arcade";
      context##.textAlign := js "left";
      let str = "Health: " in 
      context##fillText (js str) 20. 35.;
      draw_heart context (acc - 1)
    end
  in
  draw_heart context sprite.health

(**[draw_health context sprite] draws the health of [sprite] onto [context].
   1 health corresponds to 1 heart on [context]*)
let draw_score context sprite = 
  context##.fillStyle := js "white";
  context##.font := js "20px Arcade";
  context##.textAlign := js "left";
  let str = "Score: " ^ string_of_int sprite.score in
  context##fillText (js str) 20. 55.

(**[get_powerup powerup] is the power_up_type associated with [powerup]. *)
let get_powerup powerup =
  match powerup with 
  | ExtraLife a -> a 
  | _ -> failwith "unimplemented"

(**[update_powerup_animation p] updates the animation frame of powerup [p]. *)
let update_powerup_animation p =
  let powerup = get_powerup p in
  if powerup.pframe_count <= powerup.pnum_frames then
    powerup.pframe_count <- powerup.pframe_count + 1
  else
    begin
      let next_image_num = (powerup.pimage_count + 1) mod powerup.pnum_images in
      powerup.pframe_count <- 0;
      powerup.pimage_count <- next_image_num;
    end

(**[draw_extralife context powerup] draws [powerup] onto [context]. *)
let draw_extralife context powerup =
  let img = Html.createImg document in
  let (dx, dy) = (0., 0.) in
  let (w, h) = (powerup.pwidth, powerup.pheight) in
  let (x, y) = powerup.pcoordinate in
  let dy = dy +. (float_of_int powerup.pimage_count *. h) in
  img##.src := js powerup.pimage;
  context##drawImage_full img dx dy w h x y w h

(**[draw_powerups context plist] draws every element of [plist] onto
   [context].*)
let draw_powerups (context: Html.canvasRenderingContext2D Js.t) plist =
  List.map 
    (fun powerup -> 
       match powerup with
       | ExtraLife e -> draw_extralife context e
       | _ -> failwith "unimplemented") 
    plist |> ignore

(**[draw_level context level] draws the contents of [level] onto
   [context]. This includes the background, aspects, and powerups. *)
let draw_level (context: Html.canvasRenderingContext2D Js.t) level =
  draw_image context (js level.background) (0., 0.);
  draw_aspect context level.asp_list;
  draw_powerups context level.powerup_list;
  let str = level.level_name in 
  context##.fillStyle := js "white";
  context##.font := js "20px Arcade";
  context##.textAlign := js "left";
  context##fillText (js str) 20. 75.

(**[animate_on_context context sprite] updates image of [sprite] and
   draws the updated image on [context] *)
let animate_on_context context (sprite: sprite)  =
  let img = Html.createImg document in
  let (dx, dy) = sprite.offset in
  let (w, h) = sprite.image_size in
  let (x, y) = sprite.coordinate in
  let dx = dx +. (float_of_int sprite.image_count *. (w +. 1.)) in
  img##.src := js sprite.image;
  context##drawImage_full img dx dy w h x y w h

(**[draw_sprite context sprite] draws [sprite] on [context] *)
let draw_sprite context sprite =
  let new_sprite = begin 
    match sprite.name with
    | Enemy e -> update_enemy_img e sprite
    | Player -> update_sprite_img sprite; sprite
  end in
  animate_on_context context new_sprite

(**[draw_all_sprites context sprite_list] draws each sprite of [sprite_list]
   onto [context]. *)
let draw_all_sprites context sprite_list =
  List.map (fun sp -> draw_sprite context sp) sprite_list |> ignore

(**[update_animation sprite] updates the animation frame of [sprite]. *)
let update_animation sprite =
  if sprite.frame_count <= sprite.num_frames then
    sprite.frame_count <- sprite.frame_count + 1
  else
    begin
      let next_image_num = (sprite.image_count + 1) mod sprite.num_images in
      sprite.image_count <- next_image_num;
      sprite.frame_count <- 0;
    end

(**[update_all_animations spritelst poweruplst] updates the animation of
   each sprite of [spritelst] and each powerup of [poweruplst] *)
let update_all_animations (sprite_list : sprite list) powerup_list = 
  List.map update_animation sprite_list |> ignore;
  List.map update_powerup_animation powerup_list |> ignore

let draw_state (context: Html.canvasRenderingContext2D Js.t) state =
  clear context;
  if state.has_won then win_screen context else 
  if state.has_lost then lose_screen context else 
    let lvl_id = state.level in
    let curr_level = level_from_id state.levels lvl_id in
    draw_level context curr_level;
    let player = List.hd state.sprites in
    draw_health context player;
    draw_score context state;
    update_all_animations state.sprites curr_level.powerup_list;
    draw_all_sprites context state.sprites;
    draw_sprite context player;
