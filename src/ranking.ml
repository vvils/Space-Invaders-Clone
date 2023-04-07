open Util
(* give each musi*)

(** [minmax lst] is [Some (min, max)] if [min] is the smallest number in [lst]
    and [max] is the largest number in [l], or [None] if [l] is empty. *)
let rec minmax (lst : int list) : (int * int) option =
  match lst with
  | [] -> None
  | h :: t -> begin
      match minmax t with
      | None -> Some (h, h)
      | Some (min_t, max_t) ->
          if h < min_t then Some (h, max_t) else Some (min_t, max_t)
    end
(** need fixing *)

type song = {
  title : string;
  artist : string;
  duration : float;
  genre : string;
}

let rank_songs playlist user_genre =
  let weighted_score song =
    let title_score = String.length song.title |> float_of_int |> ( *. ) 0.25 in
    let artist_score =
      String.length song.artist |> float_of_int |> ( *. ) 0.15
    in
    let genre_score =
      if compare_caseless song.genre user_genre = 0 then 10. else 0.
    in
    let duration_score = song.duration *. 0.1 in
    title_score +. artist_score +. duration_score +. genre_score
  in
  let sorted_playlist =
    List.sort
      (fun song1 song2 -> compare (weighted_score song2) (weighted_score song1))
      playlist
  in
  let rec rank_helper rank acc lst =
    match lst with
    | [] -> acc
    | x :: xs ->
        let new_acc = (x, rank) :: acc in
        rank_helper (rank + 1) new_acc xs
  in
  rank_helper 1 [] sorted_playlist
;;

(* Example usage *)
let my_playlist =
  [
    {
      title = "Bohemian Rhapsody";
      artist = "Queen";
      duration = 6.07;
      genre = "Pop";
    };
    {
      title = "Stairway to Heaven";
      artist = "Led Zeppelin";
      duration = 8.02;
      genre = "Jazz";
    };
    {
      title = "Imagine";
      artist = "John Lennon";
      duration = 3.04;
      genre = "Swing";
    };
    {
      title = "Hotel California";
      artist = "Eagles";
      duration = 6.31;
      genre = "Country";
    };
    {
      title = "Sweet Child O' Mine";
      artist = "Guns N' Roses";
      duration = 5.55;
      genre = "Kpop";
    };
  ]
in
let ranked_playlist = rank_songs my_playlist "genre" in
List.iter
  (fun (song, rank) ->
    Printf.printf "Rank %d: %s - %s (%.2f mins)\n" rank song.title song.artist
      song.duration)
  ranked_playlist
