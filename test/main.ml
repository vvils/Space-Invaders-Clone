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
           ];
         to_string_list_test "for songs2" songs2 [];
       ]

let _ = run_test_tt_main suite
