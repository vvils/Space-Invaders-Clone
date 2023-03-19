open Gtk

let navbar = ()
let panels = ()
let volume = ()
let connect_spotify = ()
let display_song_info = ()

open Gtk

let main () =
  (* Initialize GTK *)
  ignore (GMain.init ());

  (* Create a new window *)
  let window = GWindow.window ~title:"Music Player" () in

  (* Create a new vertical box *)
  let vbox = GPack.vbox ~packing:window#add () in

  (* Create a new label *)
  let label = GMisc.label ~text:"Select a song:" ~packing:vbox#add () in

  (* Create a new button *)
  let button = GButton.button ~label:"Browse..." ~packing:vbox#add () in

  (* Create a new horizontal box *)
  let hbox = GPack.hbox ~packing:vbox#add () in

  (* Create a new play button *)
  let play_button = GButton.button ~stock:`MEDIA_PLAY () in
  hbox#add play_button#coerce;

  (* Create a new stop button *)
  let stop_button = GButton.button ~stock:`MEDIA_STOP () in
  hbox#add stop_button#coerce;

  (* Create a new volume slider *)
  let volume_slider =
    GRange.scale `HORIZONTAL ~draw_value:true ~packing:vbox#add ()
  in

  (* Show the window *)
  window#show ();
  GMain.Main.main ()

let () = main ()
