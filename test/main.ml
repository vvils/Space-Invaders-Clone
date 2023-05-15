open OUnit2
open Otunes
open Songfuncs

let songs = Yojson.Basic.from_file "songs.json"
let songs2 = Yojson.Basic.from_file "songs2.json"
let testing = Yojson.Basic.from_file "SongList"

let to_string_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output :
      (string * string * string * string * string * string * string) list) :
    test =
  name >:: fun _ ->
  assert_equal expected_output (to_string_list (from_json json))

let title_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (title_list (from_json json))

let genre_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (genre_list (from_json json))

let album_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (album_list (from_json json))

let ytlinks_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (ytlinks_list (from_json json))

let song_by_title_test (name : string) (title : string) (json : Yojson.Basic.t)
    (expected_output :
      (string * string * string * string * string * string * string) list) :
    test =
  name >:: fun _ ->
  assert_equal expected_output (song_by_title title (from_json json))

let song_list_by_artist_test (name : string) (artist : string)
    (json : Yojson.Basic.t)
    (expected_output :
      (string * string * string * string * string * string * string) list) :
    test =
  name >:: fun _ ->
  assert_equal expected_output (song_list_by_artist artist (from_json json))

let ytlink_by_title_test (name : string) (title : string)
    (json : Yojson.Basic.t) (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (ytlink_by_title title (from_json json))

let artist_by_title_test (name : string) (title : string)
    (json : Yojson.Basic.t) (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (artist_by_title title (from_json json))

(* let add_song_test (name : string) (title : string) (artist : string) (album :
   string) (genre : string) (length : string) (date : string) (ytlink : string)
   (expected_output : unit) : test = name >:: fun _ -> assert_equal
   expected_output (add_song_to_json title artist album genre length date
   ytlink) *)

let remove_song_test (name : string) (title : string) (artist : string)
    (json : Yojson.Basic.t) (expected_output : unit) : test =
  name >:: fun _ ->
  assert_equal expected_output
    (remove_song_to_json title artist (from_json json))

(* let string_json_test (name : string) (title : string) (str : string)
   (expected_output : unit) : test = name >:: fun _ -> assert_equal
   expected_output (json_with_string title str) *)

let printers str = str

let to_string_t (name : string) (json : Yojson.Basic.t)
    (expected_output : string) : test =
  name >:: fun _ ->
  assert_equal expected_output (Yojson.Basic.to_string json) ~printer:printers

let suite =
  "test suite for final project, OTunes"
  >::: [
         to_string_t "" songs2 {|{"songs":[]}|};
         (* string_json_test "TESTING STRING" "t" {| {} |} (); *)
         (* add_song_test "Adds a song to the song json" {|"extitle"|}
            {|"exartist"|} {|"exalbum"|} {|"exgenre"|} {|"exlength"|}
            {|"exdate"|} {|"exytlink"|} (); *)
         remove_song_test "Removes a song to song json" "extitle" "exartist"
           testing ();
         to_string_list_test "for songs" songs
           [
             ( "Pompeii",
               "Bastille",
               "Bad Blood",
               "Rock",
               "3:34",
               "2013",
               "https://www.youtube.com/watch?v=F90Cw4l-8NY" );
             ( "Für Elise",
               "Ludwig van Beethoven",
               "",
               "Classical",
               "2:55",
               "1867",
               "https://www.youtube.com/watch?v=c1iZXyWLnXg" );
             ( "Billie Jean",
               "Michael Jackson",
               "Thriller",
               "Pop",
               "4:54",
               "1983",
               "https://www.youtube.com/watch?v=Zi_XLOBDo_Y" );
             ( "What A Wonderful World",
               "Louis Armstrong",
               "What a Wonderful World",
               "Jazz",
               "2:21",
               "1967",
               "https://www.youtube.com/watch?v=VqhCQZaH4Vs" );
             ( "In Da Club",
               "50 Cent",
               "Get Rich or Die Tryin'",
               "Hip Hop",
               "3:13",
               "2003",
               "https://www.youtube.com/watch?v=5qm8PH4xAss" );
           ];
         to_string_list_test "for songs2" songs2 [];
         title_list_test "for songs" songs
           [
             "Pompeii";
             "Für Elise";
             "Billie Jean";
             "What A Wonderful World";
             "In Da Club";
           ];
         title_list_test "for songs2" songs2 [];
         genre_list_test "for songs" songs
           [ "Classical"; "Hip Hop"; "Jazz"; "Pop"; "Rock" ];
         genre_list_test "for songs2" songs2 [];
         album_list_test "for songs" songs
           [
             "Bad Blood";
             "Thriller";
             "What a Wonderful World";
             "Get Rich or Die Tryin'";
           ];
         album_list_test "for songs2" songs2 [];
         ytlinks_list_test "for songs" songs
           [
             "https://www.youtube.com/watch?v=F90Cw4l-8NY";
             "https://www.youtube.com/watch?v=c1iZXyWLnXg";
             "https://www.youtube.com/watch?v=Zi_XLOBDo_Y";
             "https://www.youtube.com/watch?v=VqhCQZaH4Vs";
             "https://www.youtube.com/watch?v=5qm8PH4xAss";
           ];
         ytlinks_list_test "for songs2" songs2 [];
         song_by_title_test "for songs" "Pompeii" songs
           [
             ( "Pompeii",
               "Bastille",
               "Bad Blood",
               "Rock",
               "3:34",
               "2013",
               "https://www.youtube.com/watch?v=F90Cw4l-8NY" );
           ];
         song_by_title_test "for songs2" "dnjlkd" songs2 [];
         song_list_by_artist_test "for songs" "Bastille" songs
           [
             ( "Pompeii",
               "Bastille",
               "Bad Blood",
               "Rock",
               "3:34",
               "2013",
               "https://www.youtube.com/watch?v=F90Cw4l-8NY" );
           ];
         song_list_by_artist_test "for songs2" "dnjlkd" songs2 [];
         ytlink_by_title_test "for songs" "Pompeii" songs
           "https://www.youtube.com/watch?v=F90Cw4l-8NY";
         ytlink_by_title_test "for songs2" "dsafds" songs2 "";
         artist_by_title_test "for songs" "Pompeii" songs "Bastille";
         artist_by_title_test "for songs2" "wrqwewq" songs2 "";
       ]

let _ = run_test_tt_main suite
