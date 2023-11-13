local music = {}

function music.play(track)
	tes3.streamMusic {
		path = track,
		situation = tes3.musicSituation.explore,
		crossfade = 5,
	}
end

return music
