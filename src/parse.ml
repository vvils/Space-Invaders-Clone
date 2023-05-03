type object_phrase = string list

type command =
  | Go of object_phrase
  | Quit

exception Empty
exception Malformed

let parse str =
  let str_lst = String.split_on_char ' ' (String.trim str) in
  match str_lst with
  | [ "" ] -> raise Empty
  | "go" :: t ->
      if t <> [] then Go (List.filter (fun b -> b <> "") t) else raise Malformed
  | [ "quit" ] -> Quit
  | _ -> raise Malformed

(* this parsing function is taken from A2, need to change. For the future, we
   like our parsing function to parse a song into

   Song Title: - Artist: - Album: -

   Description: - *)
