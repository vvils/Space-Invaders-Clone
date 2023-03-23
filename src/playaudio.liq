
<<<<<<< HEAD
security = single("playlist/2.mp3")
src = playlist("playlist")


src = fallback(track_sensitive = false, [src, security])

def function() = if source.remaining(src) < .5 then shutdown() end end


a = source.on_frame(src,function)
output.harbor(%fdkaac,mount = "/1",a)

=======
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
>>>>>>> c04bba0fc95a8bc0a87a330edceeca4244a58e84
