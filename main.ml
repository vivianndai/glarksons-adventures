open Types
open Levels
open Controller
open View
open Js_of_ocaml

module Html = Dom_html
let js = Js.string
let document = Dom_html.document

(*Canvas width*)
let canvas_width = 755.

(*Canvas height *)
let canvas_height = 600.

(* Creates the canvas and the context for our game to be drawn on. 
   Also adds listeners for key presses. *)
let start _ =
  let gui = Html.getElementById("gui") in
  let canvas = Html.createCanvas document in
  canvas##.width := 755;
  canvas##.height := 600;
  Dom.appendChild gui canvas;
  let context = canvas##getContext(Html._2d_) in
  let _ = Html.addEventListener 
      Html.document Html.Event.keydown (Html.handler Controller.keydown) 
      Js._true in 
  let _ = Html.addEventListener 
      Html.document Html.Event.keyup (Html.handler Controller.keyup)
      Js._true in
  Controller.run_game context;
  Js._false

(* Loads our game on Html window. *)
let _ =
  Html.window##.onload := Html.handler start