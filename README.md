# MulticastRTPStreamer

## How to use

Launch the binary, then use one of the following receivers:

- Gstreamer CLI (Prefered based on performance):
```
  gst-launch-1.0 -v udpsrc port=5000 multicast-group=224.2.128.0 auto-multicast=true ! application/x-rtp,encoding-name=H264 ! rtph264depay ! avdec_h264 ! autovideosink
```

- VLC:
  - CLI (you need to have the stream.sdp file generated in the folder):
    ```
    vlc stream.sdp --network-caching=100 --clock-jitter 0
    ```
  - GUI:
    1. Open VLC
    2. Use shortcut Ctrl+L
    3. Click on SAP tab located at the left panel
    4. Double click on the desired SAP stream  

- MPV CLI (you need to have the stream.sdp file generated in the folder):
```
  mpv stream.sdp --no-cache --untimed
```