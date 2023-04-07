open Bogue
open Play
module W = Widget
module L = Layout
module T = Trigger
(* open Tsdl *)

let section_title s = L.flat_of_w [ W.label ~size:12 ~fg:Draw.(opaque grey) s ]

(*Play audio by calling an Ocaml function*)
let w1 =
  let home_icon = W.icon "home" in
  let home_l = W.button ~border_radius:100 "  Home  " in
  L.flat_of_w [ home_icon; home_l ]

let testing_action =
  let home_icon = W.icon "home" in
  let home_l = W.button "  Home  " in
  L.flat_of_w [ home_icon; home_l ]

let main () =
  let width = 400 in
  (*home tab*)
  let home_icon = W.icon "home" in
  let home_l = W.button "  Home  " in
  let home_tab = L.flat_of_w [ home_icon; home_l ] in

  (* Library tab *)
  let lib_icon = W.icon "book" in
  let lib_label = W.button "  Library  " in
  let lib_tab = L.flat_of_w [ lib_icon; lib_label ] in

  (*navbar *)
  let nav_bar = L.tower ~clip:true [ home_tab; lib_tab ] in

  (* Album Playlist Panel *)
  let ap_label = W.label "Albums/Playlist" in
  let box = L.tower_of_w [ ap_label ] in

  let left_panel = L.tower [ nav_bar; box ] in
  (* main panel *)
  (* search bar *)
  let search =
    W.text_input ~size:20 ~max_size:200 ~prompt:"     search    " ()
  in
  let recent_search_labl = W.label ~size:14 "Recent Searches" in
  let stub_labl = W.label ~size:14 " " in

  let recent_played_artist_labl = W.label ~size:14 "Recently Played Artist" in
  let recent_played_songs = W.label ~size:14 "Recently Played Song" in
  let main_panel =
    L.tower_of_w
      [
        search;
        recent_search_labl;
        stub_labl;
        recent_played_artist_labl;
        recent_played_songs;
      ]
  in

  (* music*)
  let top_panel = L.flat [ left_panel; main_panel ] in

  (* music playing panel *)
  (*left side of music*)
  (* let image_title = section_title "Image display" in let image = W.image
     ~w:(width / 2) "images/play.png" in let image_layout = L.tower ~margins:0 [
     image_title; L.resident image ] in *)
  let song_title = W.label ~size:10 "Song Title" in
  let artist_name = W.label ~size:10 "     artist" in
  let description_tower = L.tower_of_w [ song_title; artist_name ] in
  let song_image = W.icon "music" in
  let music_widget = L.flat_of_w [ song_image ] in
  let left_side_music = L.flat ~sep:10 [ music_widget; description_tower ] in

  (* music control center *)
  let play_previous = W.button ~label:(Label.icon "backward") "" in
  let play_step_back = W.button ~label:(Label.icon "step-backward") "" in
  let play_next = W.button ~label:(Label.icon "forward") "" in
  let play_step_next = W.button ~label:(Label.icon "step-forward") "" in
  let play = W.button ~label:(Label.icon "play") "play" in
  let h_box_top =
    L.flat_of_w
      [ play_previous; play_step_back; play; play_step_next; play_next ]
  in
  let current_time = W.label "0:00" in
  let music_slider = W.slider ~length:80 ~step:1 100 in
  let end_time = W.label "3:46" in
  let h_box_bot = L.flat_of_w [ current_time; music_slider; end_time ] in
  let center = L.tower [ h_box_top; h_box_bot ] in

  (* volume adjustment*)
  let mic_icon = W.icon ~size:10 "volume-up" in
  let volume_slider = W.slider ~thickness:8 ~length:100 1 in
  let right_box = L.flat_of_w [ mic_icon; volume_slider ] in

  let botton_panel = L.flat [ left_side_music; center; right_box ] in

  let app_title = L.tower_of_w [ W.label "Otunes" ] in

  (* quit button *)
  let quit_title = section_title "Popup window" in
  let quit_btn = W.button ~border_radius:10 "QUIT" in
  let yes_action () = T.push_quit () in
  let no_action () = () in

  let quit_layout =
    L.tower ~margins:0 ~align:Draw.Center [ quit_title; L.resident quit_btn ]
  in

  let bottom =
    L.flat ~align:Draw.Max ~margins:0 [ Space.hfill (); quit_layout ]
  in
  L.set_width bottom width;

  (* layout *)
  let layout =
    L.tower ~clip:true [ app_title; top_panel; botton_panel; bottom ]
  in

  let board = Bogue.of_layouts [ layout ] in

  (* let window = Window.create layout in *)

  (* let _win = Window.set_size window in *)
  (* let board = Bogue.of_windows [ window ] in *)
  W.on_click ~click:(fun _ -> L.set_show main_panel false) lib_label;
  W.on_click ~click:(fun _ -> L.set_show main_panel true) home_l;
  W.on_click ~click:(fun _ -> load_audio_file ()) play;

  let release _ =
    Popup.yesno ~w:100 ~h:50 "Really quit?" ~yes_action ~no_action layout
  in
  W.on_button_release ~release quit_btn;

  Bogue.run board

let () =
  main ();
  Bogue.quit ()
