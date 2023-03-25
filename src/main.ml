
(*Play audio by calling an Ocaml function*)
let main() = ignore ( Sys.command "liquidsoap playaudio.liq")


let () = main()