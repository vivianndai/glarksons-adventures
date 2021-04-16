(**Controls the game's execution *)
open Types
open Js_of_ocaml


(**[initial_state] is the starting state. By default, the starting state is 
   level 1 scene 1. The player has neither won nor lost. *)
val initial_state : Types.state

(**Canvas width constant*)
val canvas_width : float

(**Canvas height constant*)
val canvas_height : float

(**[game_loop context] continuously updates the context to provide animation.*)
val run_game: Dom_html.canvasRenderingContext2D Js.t -> unit

(**[keydown event] registers when a key has been pressed. *)
val keydown : Dom_html.keyboardEvent Js.t -> bool Js.t

(**[keyup event] registers when a key has been lifted. *)
val keyup : Dom_html.keyboardEvent Js.t -> bool Js.t
