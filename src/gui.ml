(* #require "lablgtk3" *)
(* open Gtk *)

let navbar = ()
let panels = ()
let volume = ()
let connect_spotify = ()
let display_song_info = ()

(* let create_button_with_image img_file = let button = GButton.button () in let
   pixbuf = GdkPixbuf.from_file img_file in let image =
   Gtk.GImage.new_from_pixbuf pixbuf in button#set_image (Some image); button;
   () *)

let main () =
  (* Initialize GTK *)
  ignore (GMain.init ());

  (* Create a new window *)
  let window = GWindow.window ~title:"Otunes" ~width:1080 ~height:480 () in

  (* Create a new vertical box *)
  let vbox = GPack.vbox ~packing:window#add () in

  (*the container for the upper portion of Otunes*)
  let upper_container = GPack.hbox ~packing:vbox#add () in
  let left_vertitcal = GPack.vbox ~packing:upper_container#add () in
  let _home_button =
    GButton.toggle_button ~packing:left_vertitcal#add ~label:"Home"
    (* ~stock: (GtkStock.make_icon_source.conv GtkStock.make_icon_source
       ~filename:"images/home.png") () *)
  in
  let _library_button =
    GButton.toggle_button ~packing:left_vertitcal#add ~label:"Library" ()
  in

  (* Create a new label*)
  let _label =
    GMisc.label ~text:"Select a song:" ~packing:upper_container#add ()
  in

  (*Create a new button *)
  let _button = GButton.button ~label:"Browse..." ~packing:vbox#add () in

  (* Create a new horizontal box *)
  let hbox = GPack.hbox ~packing:vbox#add () in

  (* Create a new play button *)
  let play_button = GButton.button ~stock:`MEDIA_PLAY () in
  hbox#add play_button#coerce;

  (* Create a new stop button *)
  let stop_button = GButton.button ~stock:`MEDIA_STOP () in
  hbox#add stop_button#coerce;

  (* Create a new volume slider *)
  let _volume_slider =
    GRange.scale `HORIZONTAL ~draw_value:true ~packing:vbox#add ()
  in

  (* Show the window *)
  window#show ();
  GMain.Main.main ()

let () = main ()

let main () =
  ignore (GMain.init ());
  let window = GWindow.window ~title:"Otunes" ~width:1080 ~height:480 () in
  let vbox = GPack.vbox ~packing:window#add () in
  let _image =
    GMisc.image ~file:"/images/play.png" ~packing:vbox#add ~icon_name:"home"
      ~width:90 ~height:90 ()
  in
  window#show ();
  GMain.Main.main ()



let () = main ()