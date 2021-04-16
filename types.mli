(**All of the types in the game *)

(**[enemy_type] is the type of enemy of an enemy sprite*)
type enemies =
  | Robot
  | CompMouse
  | Camels

(**[sprite_dir] is the direction the sprite is facing *)
type sprite_dir = 
  | Right 
  | Left

(**[card_dir] is one of the four cardinal directions *)
type card_dir = 
  | North
  | South
  | East
  | West

(**[player_action] is the current action the player is displaying*)
type movements =
  | Standing
  | Jumping
  | DoubleJumping
  | Running
  | Crouching

(**[sprite_type] is the type of the sprite. It is either an enemy or 
   the player *)
type sprite_type = 
  | Enemy of enemies
  | Player

(**[velocity] is the (x,y) components of a velocity *)
type velocity = 
  {
    mutable x: float;
    mutable y: float;
  }

(**[command] is the command input by a player. *)
type command = {
  mutable up : bool;
  mutable down : bool;
  mutable left : bool;
  mutable right : bool;
}

(**[sprite] is Glarkson, our player, or an enemy*)
type sprite = {
  name : sprite_type;
  mutable action : movements;
  level_change : bool;
  mutable size : float * float;
  speed : float;
  mutable health : int;
  mutable direction : sprite_dir;
  mutable coordinate : float * float;
  level : string;
  moving : bool;
  mutable image_size : float * float;
  mutable offset : float * float;
  mutable frame_count : int;
  mutable jumping: bool;
  mutable grounded: bool;
  mutable new_jump: velocity;
  mutable send_back: bool;
  mutable ground_loc: float;
  mutable num_frames : int;
  mutable image_count : int;
  mutable num_images : int;
  image : string;
  has_won : bool;
}
(**[power_up] is a power_up aspect a sprite can pick up *)
type power_up = {
  mutable pcoordinate : float * float;
  plevel : string;
  mutable is_held : bool;
  mutable duration : int;
  pwidth : float;
  pheight : float;
  pimage : string;
  mutable pframe_count : int;
  mutable pnum_frames : int;
  mutable pimage_count : int;
  mutable pnum_images : int;
}

(**[power_up_typ] is the type of powerups the player can encounter*)
type power_up_typ =
  | None
  | ExtraLife of power_up

(**[aspect_info] contains the attributes of an aspect that is found on a
   level *)
type aspect_info = 
  {
    x_pos: float;
    y_pos: float;
    width: float;
    height: float;
    level: string;
    image: string;
    walkthrough: bool;
    item: power_up_typ;
    n_blocked: card_dir option;
    s_blocked: card_dir option;
    e_blocked: card_dir option;
    w_blocked: card_dir option
  }


(**[aspect] is a background aspect type that the player can interact with *)
type aspect =
  | GSpikes of aspect_info
  | G3Spikes of aspect_info
  | RGSpikes of aspect_info
  | LSpikes of aspect_info
  | RSpikes of aspect_info
  | Cloud of aspect_info
  | SingleBrick of aspect_info
  | Ground of aspect_info
  | Hole of aspect_info
  | PartialGround of aspect_info

(**[level] is a level in the game *)
type level =
  {
    level_name: string;
    level_id: string;
    level_width: float;
    level_height: float;
    background: string;
    sprite_list: sprite list;
    asp_list: aspect list;
    mutable powerup_list: power_up_typ list;
  }

(**[state] is the current state of the game. The state contains all the
   sprites and levels *)
type state =
  {
    mutable has_won: bool;
    mutable has_lost: bool;
    mutable level: string;
    mutable score: int;
    sprites: sprite list;
    levels: level list;
  }



(**[player_command] is the boolean associated with [command] *)
val player_command : command

(** Sprite of Glarkson*)
val player: sprite

(** Sprite of robot enemy in level 1 stage 1*)
val robot1: sprite

(** Sprite of robot enemy in level 1 stage 2*)
val robot2: sprite

(** Sprite of robot enemy in level 1 stage 2*)
val robot3: sprite

(** Sprite of robot enemy in level 1 stage 3*)
val robot4: sprite

(** Sprite of robot enemy in level 2 stage 1*)
val robot5: sprite

(** Sprite of robot enemy in level 2 stage 1*)
val robot6: sprite

(** Sprite of robot enemy in level 2 stage 1*)
val robot7: sprite

(** Sprite of camel enemy in level 3 stage 2*)
val camel1: sprite

(** Sprite of camel enemy in level 3 stage 2*)
val camel2: sprite

(** Sprite of camel enemy in level 3 stage 3*)
val camel3: sprite

(** Sprite of mice enemy in level 2 stage 1*)
val mouse1: sprite

(** Sprite of mice enemy in level 2 stage 3*)
val mouse2: sprite

(** Sprite of mice enemy in level 2 stage 3*)
val mouse3: sprite

(** Sprite of mice enemy in level 2 stage 3*)
val mouse4: sprite
