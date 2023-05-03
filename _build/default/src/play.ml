open Cmdliner

let load () = ignore (Sys.command "liquidsoap src/playaudio.liq")
let play_t () = Term.(const load $ const ())
let cmd () = Cmd.v (Cmd.info "load") (play_t ())
let load_audio_file () = exit (Cmd.eval (cmd ()))
(* let play_audio = failwith "here-unimplemented" let pause_audio = failwith
   "unimplemented" let resume_audio = failwith "unimplemented" let skip_forward
   = failwith "unimplemented" let skip_backward = failwith "unimplemented" let
   adjust_volume = failwith "unimplemented" let mute_audio = failwith
   "unimplemented" *)
