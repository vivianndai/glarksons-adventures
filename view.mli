(**Gui draws the images onto the screen *)
open Types
open Js_of_ocaml

(**Canvas width constant *)
val canvas_width: float

(**Canvas height constant *)
val canvas_height: float

(** [win_screen context] is the winning screen drawn on the context. *)
val win_screen : Dom_html.canvasRenderingContext2D Js.t -> unit

(** [lose_screen context] is the losing screen drawn on the context. *)
val lose_screen : Dom_html.canvasRenderingContext2D Js.t -> unit

(** [clear context] is the cleared context. *)
val clear : Dom_html.canvasRenderingContext2D Js.t -> unit

(** [update_enemy_img enemy_type sprite] updates the enemy's image location
    on the spritesheet. *)
val update_enemy_img : Types.enemies -> Types.sprite -> Types.sprite

(** [update_enemy_img sprite] updates the player's image location
    on the spritesheet. *)
val update_sprite_img : Types.sprite -> unit

(**[get_level_aspects aspectlist] is the list of aspect_info of an 
   aspect list. *)
val get_level_aspects : Types.aspect list -> Types.aspect_info list

(**[update_animation sprite] updates the animation frame of [sprite]. *)
val update_animation : Types.sprite -> unit

(** [draw_state context state] draws the current state onto the [context]. *)
val draw_state: Dom_html.canvasRenderingContext2D Js.t -> state -> unit
