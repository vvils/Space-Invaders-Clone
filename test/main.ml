open OUnit2
open Otunes
open Songfuncs

let data_dir_prefix = "data" ^ Filename.dir_sep
let songs = Yojson.Basic.from_file (data_dir_prefix ^ "songs.json")
let songs2 = Yojson.Basic.from_file (data_dir_prefix ^ "songs2.json")

let to_string_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output :
      (string * string * string * string * string * string * string) list) :
    test =
  name >:: fun _ ->
  assert_equal expected_output (to_string_list (from_json json))

let title_list_test (name : string) (json : Yojson.Basic.t)
    (expected_output : string list) : test =
  name >:: fun _ -> assert_equal expected_output (title_list (from_json json))

let suite =
  "test suite for final project, OTunes"
  >::: [
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
       ]

let _ = run_test_tt_main suite
