open Types
open View
open Levels
open Js_of_ocaml

module Html = Dom_html

(**String compatible with js_of_ocaml *)
let js = Js.string

let initial_state = {
  sprites = l1s1.sprite_list;
  has_won = false;
  has_lost = false;
  levels =
    [Levels.l1s1; Levels.l1s2; Levels.l1s3; Levels.l2s1; Levels.l2s2;
     Levels.l2s3;Levels.l3s1; Levels.l3s2; Levels.l3s3];
  level = "l1s1";
  score = 0;
}

let state = ref (initial_state)

let canvas_diagonal = 700.
let canvas_width = 755.
let canvas_height = 600.

let run_game context =
  let rec run_game_helper () =
    state := Model.update_state !state;
    View.draw_state context !state;
    Html.window##requestAnimationFrame
      (Js.wrap_callback 
         (fun _ -> run_game_helper ())) |> ignore
  in run_game_helper ()

let keydown event = 
  let () = match event##.keyCode with 
    (* arrow keys *)
    | 39 -> player_command.right <- true;
    | 38 -> player_command.up <- true;
    | 40 -> player_command.down <- true; 
    | 37 -> player_command.left <- true;
      (* WASD *)
    | 87 -> player_command.up <- true;
    | 83 -> player_command.down <- true;
    | 65 -> player_command.left <- true;
    | 68 -> player_command.right <- true;
      (* shift and space *)
    | 16 -> player_command.down <- true;
    | 32 -> player_command.up <- true;
    | _ -> () (* other *);
  in
  state := Model.update_state !state;
  Js._true

let keyup event = 
  let () = match event##.keyCode with 
    (* arrow keys *)
    | 38 -> player_command.up <- false;
    | 40 -> player_command.down <- false;
    | 37 -> player_command.left <- false;
    | 39 -> player_command.right <- false;
      (* WASD *)
    | 87 -> player_command.up <- false; 
    | 83 -> player_command.down <- false;
    | 65 -> player_command.left <- false; 
    | 68 -> player_command.right <- false; 
      (* shift and space *)
    | 16 -> player_command.down <- false;
    | 32 -> player_command.up <- false;
    | _ -> () (* other *)
  in
  state := Model.update_state !state;
  Js._true
