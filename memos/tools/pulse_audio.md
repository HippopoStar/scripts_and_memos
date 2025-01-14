===== ===== ===== ===== =====  
===== PULSE AUDIO  
===== ===== ===== ===== =====  

```
pactl list short modules
pactl list short sources
pactl list short sinks
pactl get-default-source
pactl get-default-sink
```
## SetUp
```
PA_MODULE_NULL_SINK=$( pactl load-module module-null-sink sink_name=mic-and-desktop )
PA_MODULE_LOOPBACK=$( pactl load-module module-loopback source=@DEFAULT_SOURCE@ sink=mic-and-desktop )
PA_MODULE_COMBINE_SINK=$( pactl load-module module-combine-sink sink_name=want-to-hear-in-mic-and-desktop slaves=mic-and-desktop,$( pactl get-default-sink ) )
```
Pulse Audio Volume Control:
- Playback: `want-to-hear-in-mic-and-desktop`
- Recording: Monitor of `mic-and-desktop`
```
dpkg-query --status pavucontrol
```
## TearDown
```
pactl unload-module "${PA_MODULE_COMBINE_SINK}"
pactl unload-module "${PA_MODULE_LOOPBACK}"
pactl unload-module "${PA_MODULE_NULL_SINK}"
```

