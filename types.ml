type enemies =
  | Robot
  | CompMouse
  | Camels

type sprite_dir = 
  | Right 
  | Left

type card_dir = 
  | North
  | South
  | East
  | West

type movements =
  | Standing
  | Jumping
  | DoubleJumping
  | Running
  | Crouching

type sprite_type = 
  | Enemy of enemies
  | Player

type velocity = 
  {
    mutable x: float;
    mutable y: float;
  }

type command = {
  mutable up : bool;
  mutable down : bool;
  mutable left : bool;
  mutable right : bool;
}

type sprite =
  {
    name: sprite_type;
    mutable action: movements;
    level_change: bool;
    mutable size: (float * float);
    speed: float;
    mutable health: int;
    mutable direction: sprite_dir;
    mutable coordinate: float * float;
    level: string;
    moving: bool;
    mutable image_size: float * float;
    mutable offset: float * float;
    (* number of frames you have been on current animation for *)
    mutable frame_count: int;
    mutable jumping: bool;
    mutable grounded: bool;
    mutable new_jump: velocity;
    mutable send_back: bool;
    mutable ground_loc: float;
    (* number of frames before changing animation *)
    mutable num_frames: int;
    (* which image of the animation cycle you are on *)
    mutable image_count: int;
    (* number of images in the animation cycle *)
    mutable num_images: int;
    image: string;
    has_won: bool;

  }

type power_up =
  {
    mutable pcoordinate: float * float;
    plevel: string;
    mutable is_held: bool;
    mutable duration: int;
    pwidth: float;
    pheight: float;
    pimage: string;

    (* number of frames you have been on current animation for *)
    mutable pframe_count: int;
    (* number of frames before changing animation *)
    mutable pnum_frames: int;
    (* which image of the animation cycle you are on *)
    mutable pimage_count: int;
    (* number of images in the animation cycle *)
    mutable pnum_images: int;
  }

type power_up_typ =
  | None
  | ExtraLife of power_up

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

type state =
  {
    mutable has_won: bool;
    mutable has_lost: bool;
    mutable level: string;
    mutable score: int;
    sprites: sprite list;
    levels: level list;
  }



let player_command = {
  up = false;
  down = false;
  left = false;
  right = false;
}

let player = 
  {
    name = Player;
    action = Standing;
    level_change = false;
    size = (22., 46.);
    speed = 3.;
    coordinate = (26., 494.);
    level = "start";
    health = 3;
    direction = Right;
    moving = false;
    image_size = (22., 46.);
    offset = (0., 0.);
    frame_count = 0;
    num_frames = 10;
    image_count = 0;
    num_images = 3;
    image = "images/Glarkson.png";
    has_won = false;
    jumping = false;
    grounded = true;
    new_jump = {x = 0.0; y = 0.0;};
    send_back = false;
    ground_loc = 484.;
  }

let robot1 = 
  {
    name = Enemy Robot;
    action = Running;
    level_change = false;
    size = (32., 62.);
    speed = 3.0;
    coordinate = (750., 487.);
    level = "l1s1";
    health = 1;
    direction = Left;
    moving = false;
    image_size = (32., 62.);
    offset = (0., 0.);
    frame_count = 0;
    num_frames = 60;
    image_count = 0;
    num_images = 2;
    image = "images/Robot.png";
    has_won = false;
    jumping = false;
    grounded = true;
    new_jump = {x = 0.0; y = 0.0;};
    send_back = false;
    ground_loc = 487.;
  }

let robot2 = {robot1 with
              coordinate = (750., 400.); level = "l1s2"}

let robot3 = {robot2 with
              coordinate = (750., 150.); level = "l1s2"; 
              speed = 5.0}

let robot4 = {robot1 with
              coordinate = (750., 135.); level = "l1s3";
              speed = 4.0}

let robot5 = {robot1 with
              coordinate = (750., 70.); level = "l2s1"}

let robot6 = {robot1 with
              coordinate = (715., 70.); level = "l2s1"}

let robot7 = {robot1 with
              coordinate = (785., 70.); level = "l2s1"}

let camel1 = 
  {
    name = Enemy Camels;
    action = Running;
    level_change = false;
    size = (98., 84.);
    speed = 2.0;
    coordinate = (750., 457.); 
    level = "l1s2";
    health = 1;
    direction = Left;
    moving = false;
    image_size = (98., 84.);
    offset = (0., 0.);
    frame_count = 0;
    num_frames = 5;
    image_count = 0;
    num_images = 3;
    image = "images/Camel.png";
    has_won = false;
    jumping = false;
    grounded = true;
    new_jump = {x = 0.0; y = 0.0;};
    send_back = false;
    ground_loc = 487.;
  }

let camel2 = 
  {camel1 with coordinate = (750., 350.); level = "l3s2"}

let camel3 = 
  {camel1 with coordinate = (785., 280.); level = "l3s3"}

let mouse1 = 
  {
    name = Enemy CompMouse;
    action = Running;
    level_change = false;
    size = (62., 24.);
    speed = 3.0;
    coordinate = (750., 515.);
    level = "l2s1";
    health = 1;
    direction = Left;
    moving = true;
    image_size = (62., 24.);
    offset = (0., 0.);
    frame_count = 0;
    num_frames = 60;
    image_count = 0;
    num_images = 2;
    image = "images/Underground/Mouse.png";
    has_won = false;
    jumping = false;
    grounded = true;
    new_jump = {x = 0.0; y = 0.0;};
    send_back = false;
    ground_loc = 487.;
  }

let mouse2 = 
  {mouse1 with coordinate = (750., 63.); level = "l2s3"}

let mouse3 = 
  {mouse1 with coordinate = (715., 63.); level = "l2s3"}

let mouse4 = 
  {mouse1 with coordinate = (785., 63.); level = "l2s3"}
