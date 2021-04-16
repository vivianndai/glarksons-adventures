open Types 

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

(* [city_g3spikes] is a 3 spike ground spike in the city stages. *)
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

(* [city_rgspikes] is a 180-degree rotated ground spike in the city stages. *)
let city_rgspikes = 
  {x_pos = 504.; y_pos = 390.; 
   width = 60.; height = 15.; 
   level = "l1s1";
   image = "images/City/RotatedSpikes.png";
   walkthrough = true;
   item = None;
   n_blocked = None;
   s_blocked = None;
   e_blocked = None;
   w_blocked = None;}

(* [city_lspikes] is a left column of spikes in the city stages. *)
let city_lspikes = 
  {x_pos = 586.; y_pos = 475.; 
   width = 15.; height = 60.; 
   level = "l1s1";
   image = "images/City/L4_Spike.png";
   walkthrough = false;
   item = None;
   n_blocked = None;
   s_blocked = None;
   e_blocked = None;
   w_blocked = None;}

(* [city_rspikes] is a right column of spikes in the city stages. *)
let city_rspikes = 
  {x_pos = 630.; y_pos = 475.; 
   width = 15.; height = 60.; 
   level = "l1s1";
   image = "images/City/R4_Spike.png";
   walkthrough = false;
   item = None;
   n_blocked = None;
   s_blocked = None;
   e_blocked = None;
   w_blocked = None;
  }

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

(* [cave_ground] is the ground in the underground stages. *)
let cave_ground = {city_ground with image = "images/Underground/UFloor.png"}

(* [cave_sblock] is a single block in the underground stages. *)
let cave_sblock = {city_sblock with image = "images/City/Brick.png" }

(* [cave_ssblock] is a (second) single block in the underground stages. *)
let cave_ssblock = {city_sblock with image = "images/Underground/Barrel.png" }

(* [cave_lspikes] is a column of left spikes in the underground stages. *)
let cave_lspikes = {city_lspikes with image = "images/City/L4_Spike.png"}

(* [cave_g3pikes] is a 3-spike ground spike in the underground stages. *)
let cave_g3spikes = {city_g3spikes with image = "images/City/G3Spikes.png"}

(* [cave_gspikes] is a ground spike in the underground stages. *)
let cave_gspikes = {city_gspikes with image = "images/City/Spikes.png"}

(* [cave_rgspikes] is a 180-degree rotated ground spike in the
   underground stages. *)
let cave_rgspikes = {city_rgspikes with
                     image = "images/City/RotatedSpikes.png"}

(* [cave_cloud] is a cloud in the underground stages. *)
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

(* [desert_ground] is the ground desert stages. *)
let desert_ground = {city_ground with image = "images/Desert/DesertGround.png"}

(* [desert_sblock] is a single block in the desert stages. *)
let desert_sblock = {city_sblock with image = "images/Desert/DesertBlock.png"}

(* [desert_gspike] is a spike in the desert stages. *)
let desert_gspike = {city_gspikes with image = "images/Desert/CactusBlock.png"; 
                                       width = 46.; height = 30.;}

(* [extra_life] is an extra life powerup the player can pick up *)
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

(* [portal] is where the player can transfer levels *)
let portal =
  {
    pcoordinate = (730., 470.);
    plevel = "l1s1";
    is_held = false;
    duration = Int.max_int;
    pwidth = 37.;
    pheight = 73.;
    pimage = "images/City/Portal.png";

    pframe_count = 0; 
    pnum_frames = 60;
    pimage_count = 0;
    pnum_images = 1;
  }

let l1s1 = 
  {
    level_name = "level 1: Stage 1";
    level_id = "l1s1";
    level_width = 754.;
    level_height = 598.;
    background = "images/City/City.png";
    sprite_list = [player; robot1];
    asp_list = [
      Ground city_ground;
      SingleBrick {city_sblock with 
                   x_pos = 290.; y_pos = 460.; 
                   e_blocked = Some East};

      SingleBrick {city_sblock with 
                   x_pos = 320.; y_pos = 430.; 
                   s_blocked = Some South; 
                   e_blocked = Some East; 
                   w_blocked = Some West};

      SingleBrick {city_sblock with 
                   x_pos = 320.; y_pos = 460.; 
                   n_blocked = Some North; 
                   e_blocked = Some East; 
                   w_blocked = Some West};

      SingleBrick {city_sblock with 
                   x_pos = 350.; y_pos = 460.; 
                   n_blocked = Some North; 
                   w_blocked = Some West};

      G3Spikes {city_g3spikes with 
                x_pos = 323.; y_pos = 418.};

      SingleBrick {city_sblock with 
                   x_pos = 470.; y_pos = 410.; 
                   e_blocked = Some East};

      SingleBrick {city_sblock with 
                   x_pos = 500.; y_pos = 410.; 
                   e_blocked = Some East; 
                   w_blocked = Some West};

      SingleBrick {city_sblock with 
                   x_pos = 530.; y_pos = 410.; 
                   w_blocked = Some West};

      GSpikes {city_gspikes with 
               x_pos = 504.; y_pos = 397.};

      RGSpikes {city_rgspikes with 
                x_pos = 504.; y_pos = 440.};

      GSpikes {city_gspikes with 
               x_pos = 170.; y_pos = 521.};

      G3Spikes {city_g3spikes with 
                x_pos = 420.; y_pos = 521.};
    ];

    powerup_list = [ExtraLife extra_life]

  }


(* --------------------------- Stage 2 --------------------------- *)
let l1s2 = 
  {
    level_name = "level 1: Stage 2";
    level_id = "l1s2";
    level_width = 754.;
    level_height = 598.;
    background = "images/City/City.png";
    sprite_list = [player; robot2; robot3];
    asp_list = [
      Ground city_ground;
      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 505.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 485.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 455.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 425.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 395.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 365.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 335.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 305.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 285.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 255.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 225.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 195.; 
                   n_blocked = Some North;
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 600.; y_pos = 165.; 
                   s_blocked = Some South;};

      SingleBrick {city_sblock with 
                   x_pos = 75.; y_pos = 460.;};

      SingleBrick {city_sblock with 
                   x_pos = 130.; y_pos = 395.;};

      SingleBrick {city_sblock with 
                   x_pos = 190.; y_pos = 330.;};

      SingleBrick {city_sblock with 
                   x_pos = 160.; y_pos = 250.;};

      SingleBrick {city_sblock with 
                   x_pos = 240.; y_pos = 280.;
                   e_blocked = Some East;};

      SingleBrick {city_sblock with 
                   x_pos = 270.; y_pos = 280.;
                   e_blocked = Some East; 
                   w_blocked = Some West};

      SingleBrick {city_sblock with 
                   x_pos = 300.; y_pos = 280.;
                   e_blocked = Some East; 
                   w_blocked = Some West};

      SingleBrick {city_sblock with 
                   x_pos = 330.; y_pos = 280.;
                   e_blocked = Some East; 
                   w_blocked = Some West;};

      SingleBrick {city_sblock with 
                   x_pos = 360.; y_pos = 280.;
                   e_blocked = Some East; 
                   w_blocked = Some West};

      G3Spikes {city_g3spikes with 
                x_pos = 307.; y_pos = 266.};

      GSpikes {city_gspikes with 
               x_pos = 333.; y_pos = 266.};

      SingleBrick {city_sblock with 
                   x_pos = 350.; y_pos = 215.;};

      SingleBrick {city_sblock with 
                   x_pos = 425.; y_pos = 140.;};

      SingleBrick {city_sblock with 
                   x_pos = 500.; y_pos = 140.;};

      SingleBrick {city_sblock with 
                   x_pos = 200.; y_pos = 60.;};

      SingleBrick {city_sblock with 
                   x_pos = 210.; y_pos = 170.;};

      SingleBrick {city_sblock with 
                   x_pos = 290.; y_pos = 90.;};

      LSpikes {city_lspikes with 
               x_pos = 586.; y_pos = 475.};

      LSpikes {city_lspikes with 
               x_pos = 586.; y_pos = 415.};

      LSpikes {city_lspikes with 
               x_pos = 586.; y_pos = 355.};

      LSpikes {city_lspikes with 
               x_pos = 586.; y_pos = 295.};

      LSpikes {city_lspikes with 
               x_pos = 586.; y_pos = 235.};

      LSpikes {city_lspikes with 
               x_pos = 586.; y_pos = 175.};

      RSpikes {city_rspikes with 
               x_pos = 630.; y_pos = 475.;};

      RSpikes {city_rspikes with 
               x_pos = 630.; y_pos = 415.;};

      RSpikes {city_rspikes with 
               x_pos = 630.; y_pos = 355.;};

      RSpikes {city_rspikes with 
               x_pos = 630.; y_pos = 295.;};

      RSpikes {city_rspikes with 
               x_pos = 630.; y_pos = 235.;};

      RSpikes {city_rspikes with 
               x_pos = 630.; y_pos = 175.;};

    ];
    powerup_list = []
  }


(* --------------------------- Stage 3 --------------------------- *)
let l1s3 = 
  {
    level_name = "level 1: Stage 3";
    level_id = "l1s3";
    level_width = 754.;
    level_height = 598.;
    background = "images/City/City.png";
    sprite_list = [player; robot4];
    asp_list = [
      Ground city_ground;

      G3Spikes {city_g3spikes with 
                x_pos = 190.; y_pos = 521.};

      GSpikes {city_gspikes with 
               x_pos = 270.; y_pos = 521.};

      GSpikes {city_gspikes with 
               x_pos = 330.; y_pos = 521.};

      GSpikes {city_gspikes with 
               x_pos = 390.; y_pos = 521.};

      GSpikes {city_gspikes with 
               x_pos = 450.; y_pos = 521.};

      GSpikes {city_gspikes with 
               x_pos = 510.; y_pos = 521.};

      GSpikes {city_gspikes with 
               x_pos = 570.; y_pos = 521.};

      GSpikes {city_gspikes with 
               x_pos = 630.; y_pos = 521.};

      SingleBrick {city_sblock with 
                   x_pos = 270.; y_pos = 470.; 
                   e_blocked = Some East};

      SingleBrick {city_sblock with 
                   x_pos = 300.; y_pos = 440.; 
                   s_blocked = Some South; 
                   e_blocked = Some East; 
                   w_blocked = Some West};

      SingleBrick {city_sblock with 
                   x_pos = 300.; y_pos = 470.; 
                   n_blocked = Some North; 
                   e_blocked = Some East; 
                   w_blocked = Some West};

      SingleBrick {city_sblock with 
                   x_pos = 330.; y_pos = 470.; 
                   n_blocked = Some North; 
                   w_blocked = Some West};

      G3Spikes {city_g3spikes with 
                x_pos = 303.; y_pos = 428.};

      SingleBrick {city_sblock with 
                   x_pos = 400.; y_pos = 415.;};

      SingleBrick {city_sblock with 
                   x_pos = 460.; y_pos = 345.;};

      (*vertical block *)

      SingleBrick {city_sblock with 
                   x_pos = 540.; y_pos = 255.;};

      SingleBrick {city_sblock with 
                   x_pos = 540.; y_pos = 285.;};

      SingleBrick {city_sblock with 
                   x_pos = 540.; y_pos = 315.;};

      SingleBrick {city_sblock with 
                   x_pos = 540.; y_pos = 345.;};

      G3Spikes {city_g3spikes with 
                x_pos = 542.; y_pos = 242.};

      LSpikes {city_lspikes with 
               x_pos = 527.; y_pos = 315.};

      LSpikes {city_lspikes with 
               x_pos = 527.; y_pos = 255.};

      RSpikes {city_rspikes with 
               x_pos = 570.; y_pos = 315.;};

      RSpikes {city_rspikes with 
               x_pos = 570.; y_pos = 255.;};

      SingleBrick {city_sblock with 
                   x_pos = 400.; y_pos = 275.;};

      SingleBrick {city_sblock with 
                   x_pos = 460.; y_pos = 205.;};

      G3Spikes {city_g3spikes with 
                x_pos = 580.; y_pos = 458.};

      G3Spikes {city_g3spikes with 
                x_pos = 608.; y_pos = 458.};

      SingleBrick {city_sblock with 
                   x_pos = 580.; y_pos = 470.; 
                   e_blocked = Some East;};

      SingleBrick {city_sblock with 
                   x_pos = 610.; y_pos = 470.; 
                   e_blocked = Some East;
                   w_blocked = Some West};

      SingleBrick {city_sblock with 
                   x_pos = 640.; y_pos = 470.; 
                   w_blocked = Some West};

    ];
    powerup_list = 
      [ExtraLife {extra_life with pcoordinate = (240., 230.); 
                                  plevel = "l1s3"}; ExtraLife portal]
  }

let l2s1 = 
  {
    level_name = "level 2: Stage 1";
    level_id = "l2s1";
    level_width = 754.;
    level_height = 598.;
    background = "images/Underground/Underground.png";
    sprite_list = [player; robot5; robot6; robot7; mouse1];
    asp_list = [
      Ground cave_ground;

      Cloud {cave_cloud with 
             x_pos = 400.; y_pos = 300.;};

      Cloud {cave_cloud with 
             x_pos = 550.; y_pos = 360.;};

      Cloud {cave_cloud with 
             x_pos = 500.; y_pos = 270.;};

      Cloud {cave_cloud with 
             x_pos = 600.; y_pos = 230.;};

      Cloud {cave_cloud with 
             x_pos = 250.; y_pos = 245.;};

      Cloud {cave_cloud with 
             x_pos = 330.; y_pos = 375.;};

      Cloud {cave_cloud with 
             x_pos = 460.; y_pos = 450.;};

      GSpikes {cave_gspikes with 
               x_pos = 190.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 250.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 310.; y_pos = 522.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 100.; y_pos = 460.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 160.; y_pos = 400.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 100.; y_pos = 340.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 160.; y_pos = 280.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 100.; y_pos = 220.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 160.; y_pos = 160.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 250.; y_pos = 160.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 340.; y_pos = 220.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 430.; y_pos = 160.;};

      SingleBrick {cave_sblock with 
                   x_pos = 490.; y_pos = 50.;};

      SingleBrick {cave_sblock with 
                   x_pos = 520.; y_pos = 50.;};

      SingleBrick {cave_sblock with 
                   x_pos = 550.; y_pos = 50.;};

      SingleBrick {cave_sblock with 
                   x_pos = 580.; y_pos = 50.;};

      SingleBrick {cave_sblock with 
                   x_pos = 610.; y_pos = 50.;};

      SingleBrick {cave_sblock with 
                   x_pos = 640.; y_pos = 50.;};

      RGSpikes {cave_rgspikes with 
                x_pos = 490.; y_pos = 80.;};

      RGSpikes {cave_rgspikes with 
                x_pos = 550.; y_pos = 80.;};

      RGSpikes {cave_rgspikes with 
                x_pos = 610.; y_pos = 80.;};

    ];
    powerup_list = 
      [ExtraLife {extra_life with pcoordinate = (450., 350.); 
                                  plevel = "l1s3"}]
  }

let l2s2 = 
  {
    level_name = "level 2: Stage 2";
    level_id = "l2s2";
    level_width = 754.;
    level_height = 598.;
    background = "images/Underground/Underground.png";
    sprite_list = [player; ];
    asp_list = [
      Ground cave_ground;

      GSpikes {cave_gspikes with 
               x_pos = 150.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 210.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 270.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 330.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 390.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 450.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 510.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 570.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 630.; y_pos = 522.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 150.; y_pos = 470.;
                   e_blocked = Some East;};

      SingleBrick {cave_sblock with 
                   x_pos = 180.; y_pos = 440.;
                   w_blocked = Some West};

      G3Spikes {cave_g3spikes with 
                x_pos = 182.; y_pos = 427.;};

      SingleBrick {cave_sblock with 
                   x_pos = 210.; y_pos = 440.;
                   w_blocked = Some West};

      SingleBrick {cave_ssblock with 
                   x_pos = 300.; y_pos = 410.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 330.; y_pos = 330.;};

      SingleBrick {cave_sblock with 
                   x_pos = 380.; y_pos = 470.;
                   e_blocked = Some East;
                   w_blocked = Some West;};

      G3Spikes {cave_g3spikes with 
                x_pos = 382.; y_pos = 457.;};

      SingleBrick {cave_sblock with 
                   x_pos = 410.; y_pos = 470.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      G3Spikes {cave_g3spikes with 
                x_pos = 442.; y_pos = 457.;};

      SingleBrick {cave_sblock with 
                   x_pos = 440.; y_pos = 470.;
                   w_blocked = Some West};

      SingleBrick {cave_ssblock with 
                   x_pos = 500.; y_pos = 440.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 550.; y_pos = 380.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 490.; y_pos = 320.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 540.; y_pos = 240.;};

      SingleBrick {cave_sblock with 
                   x_pos = 580.; y_pos = 160.;};

      SingleBrick {cave_sblock with 
                   x_pos = 610.; y_pos = 160.;};

      SingleBrick {cave_sblock with 
                   x_pos = 640.; y_pos = 160.;};

      SingleBrick {cave_sblock with 
                   x_pos = 670.; y_pos = 160.;};

      RGSpikes {cave_rgspikes with 
                x_pos = 580.; y_pos = 190.;};

      RGSpikes {cave_rgspikes with 
                x_pos = 640.; y_pos = 190.;};

      GSpikes {cave_gspikes with 
               x_pos = 580.; y_pos = 145.;};

      GSpikes {cave_gspikes with 
               x_pos = 640.; y_pos = 145.;};

    ];
    powerup_list = 
      [ExtraLife {extra_life with pcoordinate = (413., 445.); 
                                  plevel = "l2s2"}]
  }

let l2s3 = 
  {
    level_name = "level 2: Stage 3";
    level_id = "l2s3";
    level_width = 754.;
    level_height = 598.;
    background = "images/Underground/Underground.png";
    sprite_list = [player; mouse2; mouse3; mouse4];
    asp_list = [
      Ground cave_ground;
      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 505.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 475.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 445.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 415.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 385.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 355.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 325.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 295.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 265.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 235.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 205.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 175.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 145.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 115.;};

      LSpikes {cave_lspikes with
               x_pos = 718.; y_pos = 475.;};

      LSpikes {cave_lspikes with
               x_pos = 718.; y_pos = 415.;};

      LSpikes {cave_lspikes with
               x_pos = 718.; y_pos = 355.;};

      LSpikes {cave_lspikes with
               x_pos = 718.; y_pos = 295.;};

      LSpikes {cave_lspikes with
               x_pos = 718.; y_pos = 235.;};

      LSpikes {cave_lspikes with
               x_pos = 718.; y_pos = 175.;};

      LSpikes {cave_lspikes with
               x_pos = 718.; y_pos = 115.;};

      SingleBrick {cave_sblock with 
                   x_pos = 730.; y_pos = 85.;
                   w_blocked = Some West};

      SingleBrick {cave_sblock with 
                   x_pos = 700.; y_pos = 85.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 670.; y_pos = 85.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 640.; y_pos = 85.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 610.; y_pos = 85.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 580.; y_pos = 85.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 550.; y_pos = 85.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 520.; y_pos = 85.;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 520.; y_pos = 85.;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 80.; y_pos = 505.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      G3Spikes {cave_g3spikes with 
                x_pos = 83.; y_pos = 492.;};

      G3Spikes {cave_g3spikes with 
                x_pos = 113.; y_pos = 522.;};

      GSpikes {cave_gspikes with 
               x_pos = 195.; y_pos = 522.;};

      SingleBrick {cave_sblock with 
                   x_pos = 305.; y_pos = 505.;
                   w_blocked = Some West;
                   e_blocked = Some East};

      G3Spikes {cave_g3spikes with 
                x_pos = 308.; y_pos = 492.;};

      G3Spikes {cave_g3spikes with 
                x_pos = 335.; y_pos = 522.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 395.; y_pos = 460.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 440.; y_pos = 390.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 360.; y_pos = 345.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 260.; y_pos = 300.;};

      SingleBrick {cave_ssblock with 
                   x_pos = 230.; y_pos = 270.;};

      SingleBrick {cave_sblock with 
                   x_pos = 300.; y_pos = 200.;
                   e_blocked = Some East};

      SingleBrick {cave_sblock with 
                   x_pos = 330.; y_pos = 200.;
                   e_blocked = Some East;
                   w_blocked = Some West;};

      SingleBrick {cave_sblock with 
                   x_pos = 360.; y_pos = 200.;
                   e_blocked = Some East;
                   w_blocked = Some West;};

      SingleBrick {cave_sblock with 
                   x_pos = 390.; y_pos = 200.;
                   e_blocked = Some East;
                   w_blocked = Some West;};

      SingleBrick {cave_sblock with 
                   x_pos = 420.; y_pos = 200.;
                   w_blocked = Some West;};

      SingleBrick {cave_ssblock with 
                   x_pos = 470.; y_pos = 150.;};

      GSpikes {cave_gspikes with 
               x_pos = 330.; y_pos = 187.;};

      G3Spikes {cave_g3spikes with 
                x_pos = 379.; y_pos = 187.;};
    ];
    powerup_list =
      [ExtraLife {portal with pcoordinate = (730., 0.); plevel = "l2s3";
                              pimage = "images/Underground/Portal.png"; }]
  }

(* --------------------------- Stage 5 --------------------------- *)

let l3s1 = 
  {
    level_name = "level 3: Stage 1";
    level_id = "l3s1";
    level_width = 754.;
    level_height = 598.;
    background = "images/Desert/Desert.png";
    sprite_list = [player; camel1; camel2];
    asp_list = [
      Ground desert_ground;

      SingleBrick {desert_sblock with 
                   x_pos = 100.; y_pos = 460.;};

      GSpikes {desert_gspike with x_pos = 135.; y_pos = 505.};

      SingleBrick {desert_sblock with 
                   x_pos = 175.; y_pos = 385.;};

      GSpikes {desert_gspike with x_pos = 212.; y_pos = 505.};   

      SingleBrick {desert_sblock with 
                   x_pos = 250.; y_pos = 310.;};    

      GSpikes {desert_gspike with x_pos = 287.; y_pos = 95.};

      SingleBrick {desert_sblock with 
                   x_pos = 325.; y_pos = 235.;};  

      GSpikes {desert_gspike with x_pos = 465.; y_pos = 505.};  

      SingleBrick {desert_sblock with 
                   x_pos = 400.; y_pos = 160.;}; 

      GSpikes {desert_gspike with x_pos = 465.; y_pos = 95.}; 

      SingleBrick {desert_sblock with 
                   x_pos = 450.; y_pos = 270.;}; 

      GSpikes {desert_gspike with x_pos = 444.; y_pos = 240.}; 

      GSpikes {desert_gspike with x_pos = 530.; y_pos = 250.}; 

      GSpikes {desert_gspike with x_pos = 576.; y_pos = 250.}; 

      GSpikes {desert_gspike with x_pos = 622.; y_pos = 250.}; 

      GSpikes {desert_gspike with x_pos = 668.; y_pos = 250.}; 

      GSpikes {desert_gspike with x_pos = 714.; y_pos = 250.}; 

      GSpikes {desert_gspike with x_pos = 300.; y_pos = 505.};

      SingleBrick {desert_sblock with 
                   x_pos = 500.; y_pos = 380.;};  

      SingleBrick {desert_sblock with 
                   x_pos = 570.; y_pos = 400.;
                   e_blocked = Some East};  

      SingleBrick {desert_sblock with 
                   x_pos = 600.; y_pos = 400.;
                   e_blocked = Some East; w_blocked = Some West};  

      SingleBrick {desert_sblock with 
                   x_pos = 630.; y_pos = 400.;
                   e_blocked = Some East; w_blocked = Some West};  

      SingleBrick {desert_sblock with 
                   x_pos = 660.; y_pos = 400.;
                   w_blocked = Some West};  

    ];
    powerup_list = 
      [ExtraLife {extra_life with pcoordinate = (175., 360.); 
                                  plevel = "l3s1"}]
  }

let l3s2 = 
  {
    level_name = "level 3: Stage 2";
    level_id = "l3s2";
    level_width = 754.;
    level_height = 598.;
    background = "images/Desert/Desert.png";
    sprite_list = [player; robot1];
    asp_list = [
      PartialGround {desert_ground with x_pos = -700.; y_pos = 535.};

      SingleBrick {desert_sblock with 
                   x_pos = 100.; y_pos = 460.;
                   e_blocked = Some East};  

      SingleBrick {desert_sblock with 
                   x_pos = 130.; y_pos = 460.;
                   w_blocked = Some West; e_blocked = Some East}; 

      GSpikes {desert_gspike with x_pos = 160.; y_pos = 430.}; 

      SingleBrick {desert_sblock with 
                   x_pos = 160.; y_pos = 460.;
                   w_blocked = Some West; e_blocked = Some East}; 

      SingleBrick {desert_sblock with 
                   x_pos = 190.; y_pos = 460.;
                   w_blocked = Some West; e_blocked = Some East}; 

      SingleBrick {desert_sblock with 
                   x_pos = 220.; y_pos = 460.;
                   w_blocked = Some West; e_blocked = Some East}; 

      PartialGround {desert_ground with x_pos = 400.; y_pos = 535.};

      SingleBrick {desert_sblock with 
                   x_pos = 250.; y_pos = 460.;
                   w_blocked = Some West;};

      SingleBrick {desert_sblock with 
                   x_pos = 320.; y_pos = 400.;};

      SingleBrick {desert_sblock with 
                   x_pos = 350.; y_pos = 340.;};

      SingleBrick {desert_sblock with 
                   x_pos = 350.; y_pos = 310.;};

      SingleBrick {desert_sblock with 
                   x_pos = 350.; y_pos = 280.;};

      SingleBrick {desert_sblock with 
                   x_pos = 350.; y_pos = 250.;};

      SingleBrick {desert_sblock with 
                   x_pos = 230.; y_pos = 350.;};

      SingleBrick {desert_sblock with 
                   x_pos = 170.; y_pos = 300.;};

      SingleBrick {desert_sblock with 
                   x_pos = 110.; y_pos = 250.;};

      SingleBrick {desert_sblock with 
                   x_pos = 230.; y_pos = 220.;
                   e_blocked = Some East};

      SingleBrick {desert_sblock with 
                   x_pos = 260.; y_pos = 220.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 290.; y_pos = 220.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 320.; y_pos = 220.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 350.; y_pos = 220.;
                   w_blocked = Some West};

      GSpikes {desert_gspike with x_pos = 396.; y_pos = 220.}; 

      SingleBrick {desert_sblock with 
                   x_pos = 450.; y_pos = 420.;
                   e_blocked = Some East;};

      SingleBrick {desert_sblock with 
                   x_pos = 480.; y_pos = 420.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 510.; y_pos = 420.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 540.; y_pos = 420.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 570.; y_pos = 420.;
                   e_blocked = Some East; w_blocked = Some West};

      GSpikes {desert_gspike with x_pos = 570.; y_pos = 390.}; 

      SingleBrick {desert_sblock with 
                   x_pos = 600.; y_pos = 420.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 630.; y_pos = 420.;
                   w_blocked = Some West};

      GSpikes {desert_gspike with x_pos = 450.; y_pos = 505.};

      GSpikes {desert_gspike with x_pos = 450.; y_pos = 390.};

      GSpikes {desert_gspike with x_pos = 506.; y_pos = 505.};

      GSpikes {desert_gspike with x_pos = 562.; y_pos = 505.};

      GSpikes {desert_gspike with x_pos = 608.; y_pos = 505.};
    ];

    powerup_list =
      [ExtraLife {extra_life with pcoordinate = (175., 360.); 
                                  plevel = "l1s1"}]
  }

let l3s3 = 
  {
    level_name = "level 3: Stage 3";
    level_id = "l3s3";
    level_width = 754.;
    level_height = 598.;
    background = "images/Desert/Desert.png";
    sprite_list = [player;robot1; camel3];
    asp_list = [
      PartialGround 
        {desert_ground with x_pos = -70.; y_pos = 535.; 
                            width = 170.; height = 92.;
                            image = "images/Desert/desert_ground_partial.png";
                            w_blocked = Some West; e_blocked = Some East};

      SingleBrick {desert_sblock with 
                   x_pos = 145.; y_pos = 525.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 220.; y_pos = 460.;};

      SingleBrick {desert_sblock with 
                   x_pos = 145.; y_pos = 395.;
                   e_blocked = Some East; w_blocked = Some West};

      SingleBrick {desert_sblock with 
                   x_pos = 240.; y_pos = 330.;};

      SingleBrick {desert_sblock with 
                   x_pos = 340.; y_pos = 330.;};


      SingleBrick {desert_sblock with 
                   x_pos = 440.; y_pos = 330.;};

      GSpikes {desert_gspike with x_pos = 525.; y_pos = 150.};

      GSpikes {desert_gspike with x_pos = 570.; y_pos = 150.};

      GSpikes {desert_gspike with x_pos = 615.; y_pos = 150.};

      GSpikes {desert_gspike with x_pos = 660.; y_pos = 150.};

      SingleBrick {desert_sblock with 
                   x_pos = 500.; y_pos = 220.;};

      GSpikes {desert_gspike with x_pos = 500.; y_pos = 350.};

      GSpikes {desert_gspike with x_pos = 545.; y_pos = 375.};


      PartialGround 
        {desert_ground with x_pos = 210.; y_pos = 535.; 
                            width = 76.; height = 73.;
                            image = "images/Desert/desert_ground_tinyv2.png";
                            w_blocked = Some West; e_blocked = Some East};

      GSpikes {desert_gspike with x_pos = 305.; y_pos = 540.};

      PartialGround 
        {desert_ground with x_pos = 370.; y_pos = 535.; 
                            width = 76.; height = 73.;
                            image = "images/Desert/desert_ground_tinyv2.png";
                            w_blocked = Some West; e_blocked = Some East};

      GSpikes {desert_gspike with x_pos = 446.; y_pos = 535.};

      (* SingleBrick {desert_sblock with 
                   x_pos = 490.; y_pos = 525.;
                   e_blocked = Some East;}; *)

      GSpikes {desert_gspike with x_pos = 520.; y_pos = 535.};

      PartialGround 
        {desert_ground with x_pos = 590.; y_pos = 535.; 
                            width = 170.; height = 92.;
                            image = "images/Desert/desert_ground_partial.png";
                            w_blocked = Some West; e_blocked = Some East};
    ];

    powerup_list = 
      [ExtraLife {extra_life with pcoordinate = (175., 360.); 
                                  plevel = "l1s1"}]
  }