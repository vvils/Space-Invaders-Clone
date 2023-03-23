
security = single("playlist/2.mp3")
src = playlist("playlist")


src = fallback(track_sensitive = false, [src, security])

def function() = if source.remaining(src) < .5 then shutdown() end end


a = source.on_frame(src,function)
output.harbor(%fdkaac,mount = "/1",a)

