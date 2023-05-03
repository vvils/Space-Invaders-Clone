open Bogue
module W = Widget
module L = Layout
module T = Trigger

let compare_caseless s1 s2 =
  let compare_string_caseless str1 str2 =
    String.lowercase_ascii str1 = String.lowercase_ascii str2
  in
  if compare_string_caseless s1 s2 then 0 else if s1 < s2 then -1 else 1

let section_title s = L.flat_of_w [ W.label ~size:12 ~fg:Draw.(opaque grey) s ]

(* let survey_display () = let input = W.text_input ~max_size:200 ~prompt:"Enter
   your name" () in let label = W.label ~size:40 "Hello!" in let layout =
   L.tower [ L.resident ~w:400 input; L.resident ~w:400 ~h:200 label ] in

   let before_display () = let text = W.get_text input in W.set_text label
   ("Hello " ^ text ^ "!") in

   let board = Bogue.make [] [ layout ] in Bogue.run ~before_display board *)
