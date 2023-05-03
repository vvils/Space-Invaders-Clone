open Yojson.Basic.Util

type song = {
  title : string;
  artist : string;
  album : string;
  genre : string;
  length : string;
  date : string;
  ytlink : string;
}

let song_of_json json =
  {
    title = json |> member "title" |> to_string;
    artist = json |> member "artist" |> to_string;
    album = json |> member "album" |> to_string;
    genre = json |> member "genre" |> to_string;
    length = json |> member "length" |> to_string;
    date = json |> member "date" |> to_string;
    ytlink = json |> member "ytlink" |> to_string;
  }

let from_json json = json |> member "songs" |> to_list |> List.map song_of_json

let rec to_string_list lst =
  match lst with
  | [] -> []
  | h :: t ->
      (h.title, h.artist, h.album, h.genre, h.length, h.date, h.ytlink)
      :: to_string_list t

let title_list (lst : song list) : string list =
  match lst with
  | _ -> failwith "todo"

let genre_list lst =
  match lst with
  | _ -> failwith "todo"

let album_list lst =
  match lst with
  | _ -> failwith "todo"

let ytlinks_list lst =
  match lst with
  | _ -> failwith "todo"

let song_by_title title lst =
  match (title, lst) with
  | _ -> failwith "todo"

let song_list_by_artist artist lst =
  match (artist, lst) with
  | _ -> failwith "todo"

let ytlink_by_title title lst =
  match (title, lst) with
  | _ -> failwith "todo"

let artist_by_title artist lst =
  match (artist, lst) with
  | _ -> failwith "todo"
