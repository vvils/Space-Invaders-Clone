open Yojson.Basic
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

let rec title_list lst =
  match lst with
  | [] -> []
  | h :: t -> h.title :: title_list t

let genre_list lst =
  let rec helper lst =
    match lst with
    | [] -> []
    | h :: t -> h.genre :: helper t
  in
  List.sort_uniq compare (helper lst)

let rec album_list lst =
  match lst with
  | [] -> []
  | h :: t -> if h.album = "" then album_list t else h.album :: album_list t

let rec ytlinks_list lst =
  match lst with
  | [] -> []
  | h :: t -> h.ytlink :: ytlinks_list t

let rec song_by_title title lst =
  match lst with
  | [] -> []
  | h :: t ->
      if h.title = title then
        [ (h.title, h.artist, h.album, h.genre, h.length, h.date, h.ytlink) ]
      else song_by_title title t

let rec song_list_by_artist artist lst =
  match lst with
  | [] -> []
  | h :: t ->
      if h.artist = artist then
        (h.title, h.artist, h.album, h.genre, h.length, h.date, h.ytlink)
        :: song_list_by_artist artist t
      else song_list_by_artist artist t

let rec ytlink_by_title title lst =
  match lst with
  | [] -> ""
  | h :: t -> if h.title = title then h.ytlink else ytlink_by_title title t

let rec artist_by_title title lst =
  match lst with
  | [] -> ""
  | h :: t -> if h.title = title then h.artist else artist_by_title title t

let json_with_string title str = to_file title (from_string str)

(** Unable to add to an empty song list yet, and can add duplicate songs which
    needs to be fixed.*)
let add_song_to_json ti ar al ge le da yt =
  let strin = Yojson.Basic.to_string (Yojson.Basic.from_file "t") in
  let trimmed = String.sub strin 0 (String.length strin - 2) ^ "," in
  let song_str =
    {|{"title":|} ^ ti ^ {|,"artist":|} ^ ar ^ {|,"album":|} ^ al
    ^ {|,"genre":|} ^ ge ^ {|,"length":|} ^ le ^ {|,"date":|} ^ da
    ^ {|,"ytlink":|} ^ yt ^ "}"
  in
  let new_json = from_string (trimmed ^ song_str ^ "]}") in

  to_file "t" new_json
