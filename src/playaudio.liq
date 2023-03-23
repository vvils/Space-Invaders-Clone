
#!/usr/bin/liquidsoap
# Log dir
#set("log.file.path","/tmp/basic-radio.log")
#src = single("/radio/Bastille - Pompeii (Official Music Video).mp3")
# Music


# Stream it out
#output.harbor(%mp3,playlist("radio"))
srce = single("playlist/1.mp3")

output.harbor(%fdkaac,mount = "/",srce)

#shutdown()
