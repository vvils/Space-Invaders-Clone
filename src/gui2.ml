open Bogue
module W = Widget
module L = Layout

let image_file = "/images/play.png"

let main () =
  (*home tab*)
  let home_icon = W.icon "home" in
  let home_l = W.button "  Home  " in
  let home_tab = L.flat_of_w [ home_icon; home_l ] in

  (* Library tab *)
  let lib_icon = W.icon "book" in
  let lib_label = W.button "  Library  " in
  let lib_tab = L.flat_of_w [ lib_icon; lib_label ] in

  (*navbar *)
  let nav_bar = L.tower [ home_tab; lib_tab ] in

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
  let song_title = W.label ~size:10 "Song Title" in
  let artist_name = W.label ~size:10 "artist" in
  let description_tower = L.tower_of_w [ song_title; artist_name ] in
  let song_image = W.icon "music" in
  let music_widget = L.flat_of_w [ song_image ] in
  let left_side_music = L.flat [ music_widget; description_tower ] in

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

  let layout = L.tower [ top_panel; botton_panel ] in

  let board = Bogue.of_layout layout in
  Bogue.run board

(* Wilson's functions*)

let () =
  main ();
  Bogue.quit ()

