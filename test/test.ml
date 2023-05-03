open OUnit2
open Otunes
(* let pp_string s = "\"" ^ s ^ "\"" *)

let compare_string_test (name : string) (str1 : string) (str2 : string)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output
    (Util.compare_caseless str1 str2)
    ~printer:string_of_int

let input_string_test =
  [ compare_string_test "2 different cases" "hello" "Hello" 0 ]

let suite = "test suite for A2" >::: List.flatten [ input_string_test ]
let _ = run_test_tt_main suite
