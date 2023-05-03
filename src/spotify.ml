open Spotify_web_api.Search

let serialize buff alb_simp =
  Buffer.add_string buff (Album_j.string_of_album_simplified alb_simp)

let promise buff_func paging =
  Lwt.return (Album_j.string_of_paging buff_func paging)

let result () =
  let p = search_albums "Oh My My" in
  Lwt.bind (Lwt.bind p (promise serialize)) Lwt.return

let lwtprint str =
  print_string str;
  print_newline ();
  print_string "this works";
  Lwt.return ()

let yo () =
  let p = result () in
  Lwt.bind p lwtprint

(* let data_dir = "."

   let string_of_file filename = let path = Filename.concat data_dir filename in
   let chan = open_in path in try let length = in_channel_length chan in let
   buffer = Bytes.create length in really_input chan buffer 0 length; close_in
   chan; Bytes.to_string buffer with e -> close_in chan; raise e

   let test_parse_album_search () = let results = string_of_file
   "album_test.json" |> Album_j.search_wrapper_of_string |>
   Album_j.string_of_search_wrapper in results

   let () = print_string (test_parse_album_search ()) *)
