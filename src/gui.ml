open Graphics

let navbar = ()
let panels = ()
let volume = ()
let connect_spotify = ()
let display_song_info = ()

let main () =
  (* Initialize the Graphics library *)
  open_graph " 640x480";

  (* Draw a circle in the center of the screen *)
  let x, y = size () in
  let radius = min x y / 2 in
  set_color blue;
  fill_circle (x / 2) (y / 2) radius;

  (* Wait for a mouse click before exiting *)
  ignore (wait_next_event [ Button_down ])

(* Run the main function *)
let () = main ()
