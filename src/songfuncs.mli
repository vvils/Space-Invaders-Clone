type song
(** The abstract type representing a single song*)

val from_json : Yojson.Basic.t -> song list
(** [from_json j] are the songs that [j] represents. Requires: [j] is a valid
    JSON songs representation. *)

val to_string_list :
  song list ->
  (string * string * string * string * string * string * string) list
(** [to_list j] converts [j] into a list of tuples where each tuple represents a
    song and the contents in each tuple is the desirable information about that
    song. *)

val title_list : song list -> string list
(** [title_list j] returns a list of the titles of all the tracks on file.*)

val genre_list : song list -> string list
(** [genre_list j] returns a list of all the genres represented by the tracks on
    file.*)

val album_list : song list -> string list
(** [album_list j] returns a list of all the albums of tracks on file.*)

val ytlinks_list : song list -> string list
(** [ytlinks_list j] returns a list of all the ytlinks of tracks on file.*)

val song_by_title :
  string ->
  song list ->
  string * string * string * string * string * string * string
(** [song_by_title s j] returns a song in tuple form where the title of the song
    is s.*)

val song_list_by_artist :
  string ->
  song list ->
  string * string * string * string * string * string * string list
(** [song_list_by_artist s j] returns a song list in tuple list form where the
    artist of each song is s.*)

val ytlink_by_title : string -> song list -> string
(** [tylink_by_title s j] returns the ytlink of the song with title s*)

val artist_by_title : string -> song list -> string
(** [artist_by_title s j] returns the artist of the song with title s*)
