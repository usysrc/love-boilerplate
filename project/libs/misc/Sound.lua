--
--  LD24Warumup
--
--  Created by Tilmann Hars on 20.08.2012.
--  Copyright (c) 2012 Headchant. All rights reserved.
--

Sound = {}
Sound.sounds = {}
Sound.playing = {}
Sound.maxSounds = 10
Sound.currentSounds = 0


function Sound:load(str, snd)
	Sound.sounds[str] = love.sound.newSoundData(snd)
end

function Sound:play(str, vol, pitch, loop)
	vol = vol or 1
	pitch = pitch or 1
	if Sound.currentSounds < Sound.maxSounds then
		local source = love.audio.newSource(Sound.sounds[str], "static")
		source:setVolume(vol)
		source:setPitch(pitch)
		source:setLooping(loop)
		love.audio.play(source)
		table.insert(Sound.playing, source)
		Sound.currentSounds = Sound.currentSounds + 1
	end
	return Sound.currentSounds
end

function Sound:stop(num)
	local rem = num or 0
	if rem > 0 then
		love.audio.stop(Sound.playing[num])
		table.remove(Sound.playing, rem)
		Sound.currentSounds = Sound.currentSounds - 1

	end

end

function Sound:update()
	local rem = 0
	for i,v in ipairs(Sound.playing) do
		if v:isStopped() then
			rem = i
		end
	end
	if rem > 0 then
		table.remove(Sound.playing, rem)
		Sound.currentSounds = Sound.currentSounds - 1

	end
end