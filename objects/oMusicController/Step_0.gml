//Play song if it is not playing
if (!audio_is_playing(song)) audio_sound_gain(audio_play_sound(song, 1, true), musicVolume, 0);