open Bogue
module W = Widget
module L = Layout
module T = Trigger
open Tsdl

let section_title s = L.flat_of_w [ W.label ~size:12 ~fg:Draw.(opaque grey) s ]

(** [icon_button name] makes an icon button of [name] *)
let icon_button name =
  let fg = Draw.(opaque black) in
  W.button ~kind:Button.Switch ~label_on:(Label.icon ~fg name)
    ~label_off:(Label.icon ~fg:Draw.(lighter (lighter fg)) name)
    ""

let hline width =
  let style = Style.(empty |> with_bg (color_bg Draw.(transp black))) in
  L.resident (W.box ~w:width ~h:1 ~style ())

let song_title = "What is Love? - Twice"
let song_ref = "April 9th, 2018"

let fable =
  "Twice!\n\
   What is love?\n\
   매일같이 영화 속에서나\n\
   책 속에서나 드라마 속에서 사랑을 느껴\n\
   Mmm 사랑을 배워\n\
   내 일처럼 자꾸 가슴이 뛰어 두근두근거려\n\
   설레임에 부풀어 올라\n\
   Mmm 궁금해서 미칠 것만 같아\n\
   Ooh 언젠간 내게도\n\
   이런 일이 실제로 일어날까\n\
   그게 언제쯤일까? 어떤 사람일까?\n\
   I wanna know 사탕처럼 달콤하다는데\n\
   I wanna know 하늘을 나는 것 같다는데\n\
   I wanna know, know, know, know\n\
   What is love? 사랑이 어떤 느낌인지\n\
   I wanna know 하루 종일 웃고 있다는데\n\
   I wanna know 세상이 다 아름답다는데\n\
   I wanna know, know, know, know\n\
   What is love? 언젠간 나에게도 사랑이 올까\n\
   지금 이런 상상만으로도\n\
   떠올려만 봐도 가슴이 터질 것 같은데\n\
   Mmm 이렇게 좋은데\n\
   만일 언젠가 진짜로 내게\n\
   사랑이 올 때 난 울어버릴지도 몰라\n\
   Mmm 정말 궁금해 미칠 것만 같아\n\
   Ooh 언젠간 내게도\n\
   이런 일이 실제로 일어날까\n\
   Ooh, ooh, ooh 그게 언제쯤일까? 어떤 사람일까?\n\
   I wanna know 사탕처럼 달콤하다는데\n\
   I wanna know 하늘을 나는 것 같다는데\n\
   I wanna know, know, know, know\n\
   What is love? 사랑이 어떤 느낌인지\n\
   I wanna know 하루 종일 웃고 있다는데\n\
   I wanna know 세상이 다 아름답다는데\n\
   I wanna know, know, know, know\n\
   What is love? 언젠간 나에게도 사랑이 올까\n\
   지금 세상 어느 곳에 살고 있는지\n\
   도대체 언제쯤 나와 만나게 될런지\n\
   언제 우리의 인연은 시작될런지 모르지만 느낌이 어쩐지\n\
   진 진 진짜 좋을 것 같아 왠지\n\
   영화 드라마보다도 더 멋진\n\
   사랑이 올 거야 내 예감 언제나 맞지\n\
   어서 나타나봐 나는 다 준비가 됐지 ready!\n\
   찾아낼 거야\n\
   (어디 있을까) 보고 싶어 죽겠어\n\
   더 이상 참을 수 없을 것만 같아\n\
   사탕처럼 달콤하다는데\n\
   하늘을 나는 것 같다는데\n\
   I wanna know, know, know, know\n\
   What is love? 사랑이 어떤 느낌인지\n\
   하루 종일 웃고 있다는데\n\
   세상이 다 아름답다는데\n\
   I wanna know, know, know, know\n\
   What is love? 언젠간 나에게도 사랑이 올까\n\
   I wanna know, I wanna know\n\
   I wanna know, know, know, know\n\
   What is love?\n\
   I wanna know, I wanna know\n\
   I wanna know, I wanna know\n\
   I wanna know, know, know, know\n\
   What is love?\n\
   I wanna know"

(* let survey_display () = let input = W.text_input ~max_size:200 ~prompt:"Enter
   your name" () in let label = W.label ~size:40 "Hello!" in let layout =
   L.tower [ L.resident ~w:400 input; L.resident ~w:400 ~h:200 label ] in

   let before_display () = let text = W.get_text input in W.set_text label
   ("Hello " ^ text ^ "!") in

   let board = Bogue.make [] [ layout ] in Bogue.run ~before_display board *)
let after_display () = ignore (W.label "bye")

let main () =
  (* let input = W.text_input ~max_size:200 ~prompt:"Enter your name" () in *)
  let label = W.label ~size:40 "Hello!" in
  


  let before_survey_display () =
    (* let text = W.get_text input in *)
    W.set_text label ("Questionnaire Time!") in
    (* let question_one = W.html ~h:20 ("<strong> What are your favorite genres? </strong>") in *)

    let check_title = W.html ~h:20 ("<strong> What are your favorite music genres? </strong>") in 
    let check1 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "Pop" ] in let check2 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "Classical" ] in let check3 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "Rock" ] in let check4 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "Country" ] in let question_1 = L.tower
    ~margins:10 ~sep:0 [ L.resident ~w:400 ~h:20 check_title; check1; check2; check3; check4 ] in

    let check_title = W.html ~h:20 ("<strong> What are your favorite eras of music? </strong>") in 
    let check1 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "pre-1800s" ] in let check2 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "1850-1900s" ] in let check3 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "1900-1950s" ] in let check4 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "1950-2000s" ] in let check5 = L.flat_of_w
    ~sep:2 [ W.check_box (); W.label "2000-Present" ] in let question_2 = L.tower
    ~margins:10 ~sep:0 [ L.resident ~w:400 ~h:20 check_title; check1; check2; check3; check4;check5 ] in

      (* let radio_title = section_title "Radio buttons. Only one can be selected."
     in let radio = Radiolist.vertical [| "select this"; "or rather that";
     "maybe this"; "worst case, this one"; |] in let radio_layout = L.tower
     ~margins:0 ~sep:0 [ radio_title; Radiolist.layout radio ] in *)

    let survey =
      L.tower [ L.resident ~w:400 ~h:70 label; question_1; question_2 ]
    in
    
    (* let question_1 = "What ?" in let text = W.text_display ~w:width ~h:630 question_1 in

    let text_ref =
      W.rich_text ~w:width ~h:20 Text_display.(page [ italic (para song_ref) ])
    in
    let text_layout =
      L.tower
        [  L.resident text; L.resident text_ref ]
    in
    let text_container = L.make_clip ~h:340 text_layout in

    let survey_page =
      L.tower
        [
          text_container;
        ]
    in *)

  let width = 400 in

  (* quit button *)
  let quit_title = section_title "Popup window" in
  let quit_btn = W.button ~border_radius:10 "QUIT" in
  let yes_action () = T.push_quit () in
  let no_action () = () in

  let quit_layout =
    L.tower ~margins:0 ~align:Draw.Center [ quit_title; L.resident quit_btn ]
  in

  (* Page 1: check buttons, radio, and text scrolling *)
  let input_title = section_title "Text input" in
  let ti = W.text_input ~prompt:"What you looking for ? " () in
  let input =
    L.flat_of_w ~align:Draw.Center [ W.label "Enter your name:"; ti ]
  in
  let input_layout = L.tower ~margins:0 [ input_title; input ] in

  let hello_title = section_title "Dynamic text" in
  let hello = W.label ~size:40 "Hello!" in
  let hello_action = W.map_text (fun s -> "Hello " ^ s ^ "!") in
  let c_hello =
    W.connect ti hello hello_action Sdl.Event.[ text_input; key_down ]
  in
  let hello_layout =
    L.tower ~margins:0 [ hello_title; L.resident ~w:width hello ]
  in

  (* let check_title = section_title "Check buttons" in let check1 = L.flat_of_w
     ~sep:2 [ W.check_box (); W.label "check this" ] in let check2 = L.flat_of_w
     ~sep:2 [ W.check_box (); W.label "check that" ] in let check3 = L.flat_of_w
     ~sep:2 [ W.check_box (); W.label "or this" ] in let check_layout = L.tower
     ~margins:0 [ check_title; check1; check2; check3 ] in *)

  (* let radio_title = section_title "Radio buttons. Only one can be selected."
     in let radio = Radiolist.vertical [| "select this"; "or rather that";
     "maybe this"; "worst case, this one"; |] in let radio_layout = L.tower
     ~margins:0 ~sep:0 [ radio_title; Radiolist.layout radio ] in *)

  (* let icon_title = section_title "Icon buttons." in let icon1 = icon_button
     "play" in let icon2 = icon_button "pause" in let icon3 = icon_button "stop"
     in let icon4 = icon_button "repeat" in let icons = L.flat_of_w [ icon1;
     icon2; icon3; icon4 ] in let icon_layout = L.tower ~margins:0 [ icon_title;
     icons ] in *)
  let text_title = section_title "Fetched Song Description" in
  let text_head =
    W.rich_text ~size:20 ~w:width ~h:30
      Text_display.(page [ bold (para song_title) ])
  in
  let text = W.text_display ~w:width ~h:630 fable in
  let text_ref =
    W.rich_text ~w:width ~h:20 Text_display.(page [ italic (para song_ref) ])
  in
  let text_layout =
    L.tower
      [ text_title; L.resident text_head; L.resident text; L.resident text_ref ]
  in
  let text_container = L.make_clip ~h:340 text_layout in

  let page1 =
    L.tower
      [
        quit_layout;
        input_layout;
        hline width;
        hello_layout;
        (* hline width; icon_layout; hline width; check_layout; hline width;
           radio_layout; *)
        hline width;
        text_container;
      ]
  in

  (* Page 2: text input ... *)
  (* let input_title = section_title "Text input" in let ti = W.text_input
     ~prompt:"John Doo-Doo Wap" () in let input = L.flat_of_w ~align:Draw.Center
     [ W.label "Enter your name:"; ti ] in let input_layout = L.tower ~margins:0
     [ input_title; input ] in

     let hello_title = section_title "Dynamic text" in let hello = W.label
     ~size:40 "Hello!" in let hello_action = W.map_text (fun s -> "Hello " ^ s ^
     "!") in let c_hello = W.connect ti hello hello_action Sdl.Event.[
     text_input; key_down ] in let hello_layout = L.tower ~margins:0 [
     hello_title; L.resident ~w:width hello ] in *)
  let play_button = icon_button "play" in

  (* layout *)
  let layout_gui2 =
    L.tower ~margins:0
      [ section_title "Play button"; L.resident ~w:(width / 8) play_button ]
  in
  (******************************************************)
  let slider_title = section_title "Progress bar or slider" in
  let slider = W.slider ~kind:Slider.HBar 100 in
  let percent = W.label "    0%" in
  let set_percent w x = Label.set (W.get_label w) (Printf.sprintf "%u%%" x) in
  let action w1 w2 _ =
    let x = Slider.value (W.get_slider w1) in
    set_percent w2 x
  in
  let events =
    List.flatten
      [ T.buttons_down; T.buttons_up; T.pointer_motion; [ Sdl.Event.key_down ] ]
  in
  let c_slider = W.connect slider percent action events in
  let slider_l = L.resident ~background:L.theme_bg slider in
  let slider_bar = L.flat ~align:Draw.Center [ slider_l; L.resident percent ] in
  let slider_layout = L.tower ~margins:0 [ slider_title; slider_bar ] in

  let buttons_title = section_title "Push and toggle buttons" in
  let button_reset = W.button ~border_radius:10 "Reset" in
  let click _ =
    Slider.set (W.get_slider slider) 0;
    Label.set (W.get_label percent) " 0%"
    (* it would be great if this could be done automatically. *)
  in
  W.on_click ~click button_reset;
  let button_start =
    W.button ~border_radius:10 ~kind:Button.Switch "Start computing"
  in
  let start_action b s ev =
    let bw = W.get_button b in
    let sw = W.get_slider s in
    let state = Button.state bw in
    if state then
      let rec loop () =
        let x = Slider.value sw in
        if x >= 100 || T.should_exit ev then (
          T.will_exit ev;
          Button.reset bw)
        else (
          Slider.set sw (x + 1);
          set_percent percent (x + 1);
          W.update s;
          T.nice_delay ev 0.1;
          loop ())
      in
      loop ()
    else W.update percent
  in
  let c_button =
    W.connect ~priority:W.Replace button_start slider start_action T.buttons_up
  in

  let buttons_layout =
    L.tower ~margins:0
      [ buttons_title; L.flat_of_w [ button_reset; button_start ] ]
  in

  (* images *)
  (* let image_title = section_title "Image display" in let image = W.image
     ~w:(width / 2) "images/play.png" in let image_layout = L.tower ~margins:0 [
     image_title; L.resident image ] in

     let bottom = L.flat ~align:Draw.Max ~margins:0 [ image_layout; Space.hfill
     () ] in L.set_width bottom width; *)
  let page2 =
    L.tower
      [
        layout_gui2;
        hline width;
        slider_layout;
        hline width;
        buttons_layout;
        hline width 
        (* bottom; *);
      ]
  in

  let tabs =
    Tabs.create ~slide:Avar.Right
      [ ("Artist descriptions", page1); ("Music Playing", page2) ]
  in

  (* Notice we need to put this code after definition of the main layout. *)
  let release _ =
    Popup.yesno ~w:100 ~h:50 "Really quit?" ~yes_action ~no_action tabs
  in
  W.on_button_release ~release quit_btn;

  W.on_click ~click:(fun _ -> Play.load_audio_file ()) play_button;
  let board = Main.make [ c_hello; c_slider; c_button ] [ tabs; survey ] in
  Main.run ~before_display:before_survey_display board

let () =
  main ();
  Bogue.quit ()
