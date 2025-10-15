# MulticastRTPStreamer

- FFmpeg (Windows Streamer):

```
  ffmpeg -f gdigrab -framerate 30 -offset_x 0 -offset_y 0 -video_size 1920x1080 -i desktop -c:v libx264 -preset ultrafast -tune zerolatency -f rtp rtp://224.2.128.0:5000 -sdp_file ./stream.sdp
```

- Gstreamer (Receiver):
```
  gst-launch-1.0 -v udpsrc port=5000 multicast-group=224.2.128.0 auto-multicast=true ! application/x-rtp,encoding-name=H264 ! rtph264depay ! avdec_h264 ! autovideosink
```

- VLC (Receiver):
```
  vlc stream.sdp --network-caching=100 --clock-jitter 0
```

- MPV (Receiver):
```
  mpv stream.sdp --no-cache --untimed
```
