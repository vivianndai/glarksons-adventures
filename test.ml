open OUnit2
open Model
open Types
open Levels

(*Player commands/Keyboard inputs was done visually since you test what the 
  sprite and the aspects on the screen are doing based on your input of the key. 
  Additionally, OUnit2 is not the optimal testing method due to the listener 
  that is used in main.ml. The listener is integrated into the game and is
  really diffcult to replicate in a testing file. 

  State changes such as traveling from one level to another and jumping 
  facilities were able to be checked manually. We methodically went through 
  each aspect on every stage to make sure collisions were properly working.
  Visual testing was by far the most important form of testing as it also 
  allowed testing of view. Drawing and animation are only able to be tested 
  manually. 

  We omitted testing for functions that returned type unit () because we felt
  that manual Ounit test cases would be ineffecitve at simulationg the 
  potential side effects of these functions that would occur during normal
  gameplay. During normal gameplay, there are many more elements at play than
  we could simulate during testing. As a result, we decided to test the 
  functional aspects of the game in our test cases, then asses the mutable 
  features those functional tests operate on via playtesting in the game itself

  Tests were developed using white box testing, as the scope of the game 
  meant that we often had to write functions by trial-and-error and could not
  always invest the time to write test cases in advances for functions we may
  end up deleting after quickly seeing that they are unneeded or do not work 
  properly during play-testing.

  The test suite at hand demonstrates the correctness of the given system
  because it thoroughly tests critical functional aspects of the program --
  the building blocks upon which the imperative aspects depend. In testing 
  these functional aspects, we also test the validity of the many data types we
  had to develop for the project.

  As stated previously, the functional aspects of the program were tested 
  manually, others were tested with user testing and a level design that would
  probe all features of the game. Automatic testing was not used. *)

let player = 
  {name = Player;
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

(* [city_sblock] is a single block in the city stages. *)
let city_sblock = 
  {x_pos = 290.; y_pos = 390.;
   width = 30.; height = 30.; 
   level = "l1s1";
   image = "images/City/Brick.png";
   walkthrough = false;
   item = None;
   n_blocked = None;
   s_blocked = None;
   e_blocked = None;
   w_blocked = None;
  }

(* [city_gspikes] is a ground spike in the city stages. *)
let city_gspikes = 
  {x_pos = 320.; y_pos = 375.; 
   width = 60.; height = 15.; 
   level = "l1s1";
   image = "images/City/Spikes.png";
   walkthrough = true;
   item = None;
   n_blocked = None;
   s_blocked = None;
   e_blocked = None;
   w_blocked = None;}

(* [city_g3spikes] is a 3-spike ground spike in the city stages. *)
let city_g3spikes = 
  {x_pos = 320.; y_pos = 375.; 
   width = 20.; height = 10.; 
   level = "l1s1";
   image = "images/City/G3Spikes.png";
   walkthrough = true;
   item = None;
   n_blocked = None;
   s_blocked = None;
   e_blocked = None;
   w_blocked = None;}

(* [city_ground] is the ground in the city stages. *)
let city_ground =  
  {x_pos = 0.; y_pos = 535.; 
   width = 760.; height = 600.; 
   level = "l1s1";
   image = "images/City/Platform.png";
   walkthrough = false;
   item = None;
   n_blocked = None;
   s_blocked = None;
   e_blocked = None;
   w_blocked = None;}

let cave_cloud = 
  {x_pos = 0.; y_pos = 535.; 
   width = 19.; height = 9.; 
   level = "l2s1";
   image = "images/Underground/Cloud1.png";
   walkthrough = false;
   item = None;
   n_blocked = None;
   s_blocked = None;
   e_blocked = None;
   w_blocked = None;}

let (extra_life : Types.power_up) =
  {
    pcoordinate = (400., 400.);
    plevel = "l1s1";
    is_held = false;
    duration = Int.max_int;
    pwidth = 20.;
    pheight = 25.;
    pimage = "images/PowerUps/HeartPowerUp.png";

    pframe_count = 0; 
    pnum_frames = 5;
    pimage_count = 1;
    pnum_images = 16;
  }

let initial_state = {
  sprites = [player;robot1];
  has_won = false;
  has_lost = false;
  levels =
    [l1s1; l2s1];
  level = "l1s1";
  score = 0;
}

(** [size_test name dict expected_output] constructs an OUnit
      test named [name] that asserts the quality of [expected_output]
      with [IntIntDictionary.size dict]. *)
let level_from_id_test 
    (name)
    (levels_list) 
    (level_id) 
    (expected_output : level) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (level_from_id levels_list level_id))

let complex_state = {
  sprites = [player;robot1];
  has_won = false;
  has_lost = false;
  levels =
    [l1s1; l1s2];
  level = "l1s1";
  score = 0;
}

let state_won = {initial_state with has_won = true}

let state_lost = {initial_state with has_lost = true}

let player_no_health = {player with health = 0}

let player_past_win_loc = 
  {player with coordinate = (755., 100. )}

let player_starting_loc = 
  {player with coordinate = ( 15., 494. );
               level_change = true}

let complex_state_next =  {complex_state with level = "l1s2";}

let player_command = {
  up = false;
  down = false;
  left = false;
  right = false;
}

let up_command = {player_command with up = true}
let down_command = {player_command with down = true}
let left_command = {player_command with left = true}
let right_command = {player_command with right = true}

(** [no_health_test name state sprite expected_output] constructs an OUnit
      test named [name] that asserts the quality of [expected_output]
      with [update_health state sprite]. *)
let no_health_test (name) (state) (sprite) (expected_output) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (update_health state sprite))

(** [next_stage_test name state sprite expected_output] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [next_stage_state state sprite]. *)
let next_stage_state_test (name) (state) (sprite) (expected_output) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (next_stage_state state sprite))

(** [reset_pos_test name state sprite expected_output] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [reset_pos spritlst xpos ypos]. *)
let reset_pos_test (name) (spritelst) (xpos) (ypos) (expected_output) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output 
        (List.hd (reset_sprite 3 spritelst xpos ypos)))

(** [next_stage_test name state sprite expected_output] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [next_stage state sprite]. *)
let next_stage_test (name) (state) (sprite) (expected_output) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (next_stage state sprite))

(** [alive_after_test name state sprite expected_output] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [alive_after_collision dir player enemy]. *)
let alive_after_test (name) (dir) (player) (enemy) (state) 
    (expected_output) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (alive_after_collision dir player enemy 
                                      state))

(** [update_action_test name command sprite] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [update_action command sprite]. *)
let update_action_test (name) (command) (sprite) (expected_output) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (update_action command sprite))

(** [all_but_current_test name command sprite] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [update_action command sprite]. *)
let all_but_current_test name id current level expected_output: test= 
  name >:: (fun _ -> 
      assert_equal expected_output (all_but_current id current level))

(** [op_both_test name command sprite] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [op_on_both tup1 tup2 op]. *)
let op_both_test name tup1 tup2 op expected_output: test= 
  name >:: (fun _ -> 
      assert_equal expected_output (op_on_both tup1 tup2 op))

let initial_command =
  {up = false;
   down = false;
   left = false;
   right = false;}

let up_pressed = {initial_command with up = true}
let down_pressed = {initial_command with down = true}
let right_pressed = {initial_command with right = true}
let left_pressed = {initial_command with left = true}


(** [lst_current_keys_test name key_assoc_lst result] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [lst_current_keys key_assoc_lst result]. *)
let lst_current_keys_test 
    (name)
    (key_assoc_lst) 
    (result) 
    (expected_output : card_dir list) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (lst_current_keys key_assoc_lst result))

(** [next_level_id_test name level_lst curr_level] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [next_level_id level_lst curr_level]. *)
let next_level_id_test 
    (name)
    (level_lst) 
    (curr_level) 
    (expected_output : string) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (next_level_id level_lst curr_level))

(** [get_lvl_aspect_test name aspect] constructs an OUnit
    test named [name] that asserts the quality of [expected_output]
    with [get_lvl_aspect aspect]. *)
let get_lvl_aspect_test 
    (name)
    (aspect) 
    (expected_output : aspect_info) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (get_lvl_aspect aspect))

(**[print_tuple tp] prints the tuple [tp] for debugging purposes*)
let print_tuple tp =
  string_of_float (fst tp) ^ "," ^ string_of_float (snd tp)
let tests = [
]
let update_enemy_location_test name output sprite state =
  name >:: fun _ -> 
    assert_equal output.coordinate 
      (update_enemy_location sprite state).coordinate
      ~printer:print_tuple

let answer_1 = {robot1 with coordinate =(750.,487.)}

let robot1mod = {robot1 with send_back = true}
let answer_2 = {robot1 with coordinate =(750.,487.)}

let playerupdate1 = {player with coordinate =(270.,450.)}

let playermod = {player with coordinate =(298.,450.)}
let playermod2 = {player with coordinate =(298.,414.)}
let playermod3 = {player with coordinate =(298.,420.)}
let playerupdate = {player with coordinate =(298.,470.)}

let aspect1 = SingleBrick {city_sblock with 
                           x_pos = 290.; y_pos = 460.;}

let playermod4 = {player with coordinate =(390.,390.)}
let playerupdate2 = {player with coordinate =(400.,390.)}
let playerupdate3 = {player with coordinate =(400.,420.)}


let playerupdate4 = {player with coordinate =(400.,370.)}                             
let extra_life =
  {
    pcoordinate = (400., 400.);
    plevel = "l1s1";
    is_held = false;
    duration = Int.max_int;
    pwidth = 20.;
    pheight = 25.;
    pimage = "images/PowerUps/HeartPowerUp.png";

    pframe_count = 0; 
    pnum_frames = 5;
    pimage_count = 1;
    pnum_images = 16;
  }
let playermod5 = {player with coordinate = (300., 487.)}
let playermod6 = {player with coordinate =(320., 487.)}

let playermod7 = {player with coordinate =(350., 487.)}
let playermod8 = {player with coordinate =(340., 530.)}
let playermod9 = {player with coordinate =(340., 445.)}
let robot5 = {robot1 with coordinate = (340., 487.)}

let check_pw_collision_test name output player powerup =
  name >:: fun _ -> 
    assert_equal output (check_pw_collision player powerup)

let check_aspect_collision_test name output sprite aspect =
  name >:: fun _ -> 
    assert_equal output (check_aspect_collision sprite aspect)

let check_sprite_collision_test name output player enemy =
  name >:: fun _ -> 
    assert_equal output (check_sprite_collision player enemy)

let enem_state = {
  sprites = [robot5];
  has_won = false;
  has_lost = false;
  levels = [l1s3];
  level = "l1s3";
  score = 0;
}

let check_enemy_collision_test name output enemy_list state sprite =
  name >:: fun _ -> 
    assert_equal output (enemy_collision enemy_list state sprite)

let tests = [
  no_health_test "testing if player no health changes state to has lost"
    initial_state player_no_health state_lost;

  no_health_test "testing if player with health doesn't changes state"
    initial_state player initial_state;

  next_stage_state_test "player not far enough on level to win" 
    initial_state player initial_state;

  reset_pos_test "player location being reset to the beginning"
    initial_state.sprites 15. 494. player_starting_loc;

  next_stage_test "player is on last stage" initial_state player "l1s1";

  next_stage_test "player is not on last stage" complex_state player "l1s1";

  next_stage_test "player is past location" 
    complex_state player_past_win_loc "l1s2";

  alive_after_test "player hits robot on south side" South player robot1 
    initial_state false;

  alive_after_test "player hits robot on north side" North player robot1 
    initial_state true;

  alive_after_test "player hits robot on east side" East player robot1 
    initial_state true;

  alive_after_test "player hits robot on west side" West player robot1 
    initial_state true;

  check_enemy_collision_test "player collision with robot1" 
    [robot1] [robot1] initial_state player;

  check_enemy_collision_test "playermod6 collision with robot1" 
    [robot1] [robot1] enem_state playermod6;

  check_enemy_collision_test "playermod4 collision with robot1mod" 
    [robot1mod] [robot1mod] enem_state playermod4;

  update_action_test "resulting action with command up true" 
    up_command player Jumping; 

  update_action_test "resulting action with command down true"
    down_command player Crouching; 

  update_action_test "resulting action with command left true"
    left_command player Running; 

  update_action_test "resulting action with command right true"
    right_command player Running; 

  update_action_test "resulting action with no command" 
    player_command player Standing; 

  all_but_current_test "level id = current id" "l1s2" l1s2 l1s1 l1s1;

  all_but_current_test "level id <> current id" "l1s1" l1s2 l1s1 l1s2;

  op_both_test "testing operation on float tuples" (2.,4.) (3.,5.) ( +. ) 
    (5.,9.);

  update_enemy_location_test "test1: increments robot1 by one placement. 
     Should return location coordinates 747,487" answer_1 robot1 initial_state;

  update_enemy_location_test "test2: robot1 with send_back is true. 
     Should return a sprite with initial location." 
    robot1 robot1mod initial_state;

  check_aspect_collision_test "sees if there is a collision between playermod 
  and aspect1" (Some East) playerupdate1 aspect1;

  check_aspect_collision_test "sees if there is a collision between playermod 
  and aspect1" (Some West) playermod aspect1;

  check_aspect_collision_test "sees if there is a collision between playermod2 
  and aspect1" None playermod2 aspect1;

  check_aspect_collision_test "sees if there is a collision between playermod3 
  and aspect1" (Some South) playermod3 aspect1;

  check_aspect_collision_test "sees if there is a collision between playerupdate 
  and aspect1" (Some North) playerupdate aspect1;

  check_pw_collision_test "sees if there is a collision between playerupdate2
   and extra_life" (Some West) playerupdate2 extra_life;

  check_pw_collision_test "sees if there is a collision between playermod4 and 
     extra_life" (Some East) playermod4 extra_life;

  check_pw_collision_test "sees if there is a collision between playerupdate3
   and extra_life" (Some North) playerupdate3 extra_life;

  check_pw_collision_test "sees if there is a collision between playerupdate4
   and extra_life" (Some South) playerupdate4 extra_life;

  check_pw_collision_test "sees if there is a collision between playermod3 and 
     extra_life" None playermod3 extra_life;

  check_sprite_collision_test "sees if there is a collision between playermod5 
  and robot5" None playermod5 robot5;

  check_sprite_collision_test "sees if there is a collision between playermod6 
  and robot5" (Some East) playermod6 robot5;

  check_sprite_collision_test "sees if there is a collision between playermod7 
  and robot5" (Some West) playermod7 robot5;

  check_sprite_collision_test "sees if there is a collision between playermod8 
  and robot5" (Some North) playermod8 robot5;

  check_sprite_collision_test "sees if there is a collision between playermod9 
  and robot5" (Some South) playermod9 robot5;

  level_from_id_test "list of 2 levels" initial_state.levels "l2s1" l2s1;

  level_from_id_test "list of 2 levels" initial_state.levels "l1s1" l1s1;

  lst_current_keys_test "West direction" [(left_pressed.left, West)] [] [West];

  lst_current_keys_test "East direction" [(right_pressed.right, East)] 
    [] [East];

  lst_current_keys_test "South direction" [(down_pressed.down, South)] 
    [] [South];

  lst_current_keys_test "East and West at once"
    [(right_pressed.right, East); (left_pressed.left, West)] [] [West; East];

  lst_current_keys_test "East and North at once"
    [(right_pressed.right, East); (up_pressed.up, North)] [] [North; East];

  next_level_id_test "Stage2 -> Stage3" [l1s1; l1s2; l1s3] "l1s2" "l1s3";

  next_level_id_test "level1 -> level2" [l1s1; l1s2; l1s3; l2s1] "l1s3" "l2s1";

  get_lvl_aspect_test "retreiving info about ground" (Ground city_ground)
    city_ground; 

  get_lvl_aspect_test "retreiving info about cloud" (Cloud cave_cloud)
    cave_cloud; 

  get_lvl_aspect_test "retreiving gspike info" (GSpikes city_gspikes) 
    city_gspikes;
]

let suite = "suite" >::: tests

let _ = run_test_tt_main suite