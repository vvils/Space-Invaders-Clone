
security = single("src/playlist/2.mp3")
src = playlist("src/playlist")


src = fallback(track_sensitive = false, [src, security])

def function() = if source.remaining(src) < .2 then shutdown() end end


# src2 = single("src/playlist/1.mp3")

a = source.on_frame(src,function)
output.harbor(%fdkaac,mount = "/1", a)

