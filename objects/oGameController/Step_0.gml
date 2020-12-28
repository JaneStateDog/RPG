//Use master volume to set all volume at all times
var num = audio_get_listener_count();
for (i = 0; i < num; i++) {
   var info = audio_get_listener_info(i);
   audio_set_master_gain(info[? "index"], masterVolume);
   ds_map_destroy(info);
}