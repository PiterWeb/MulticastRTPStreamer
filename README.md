# MulticastRTPStreamer

## General prerequisites:

Having ffmpeg installed & included in the PATH [Guide](https://ffmpeg.org/download.html)

## How to use

Launch the binary, then use one of the following receivers:

> [!NOTE]  
> All the CLI receivers have a script inside [scripts folder](./scripts/)

- Gstreamer CLI (Prefered based on performance):</br>
  Prerequisites: Gstreamer runtime installed [Guide](https://gstreamer.freedesktop.org/documentation/installing/index.html?gi-language=c)
```bash
gst-launch-1.0 -v udpsrc port=5000 multicast-group=224.2.128.0 auto-multicast=true ! application/x-rtp,encoding-name=H264 ! rtph264depay ! avdec_h264 ! autovideosink
```

- VLC:</br>
  Prerequisites: VLC installed [Guide](https://www.videolan.org/vlc/#download)
  - CLI (you need to have the stream.sdp file generated in the folder):
    ```bash
    vlc stream.sdp --network-caching=100 --clock-jitter 0
    ```
  - GUI ([VLC Docs](https://prime-5.videolan.me/vlc-user/vlm_files/en/advanced/streaming/sap_session.html#connecting-to-a-sap-stream))
    1. Open VLC
    2. Use shortcut Ctrl+L
    3. Click on SAP tab located at the left panel
    4. Double click on the desired SAP stream

- MPV CLI (you need to have the stream.sdp file generated in the folder):</br>
  Prerequisites: MPV installed [Guide](https://mpv.io/installation/)
```bash
mpv stream.sdp --no-cache --untimed
```

## Technical doc

This project consists on an executable (CLI) written in VLang (or V).
This CLI uses under the hood FFMPEG binary to record and stream the desktop screen.
In the executable is also included a SAP announcer that follows most of the [RFC spec](https://datatracker.ietf.org/doc/html/rfc2974) written from scratch.

## Build yourself

### Prerequisites

- Having [Vlang](https://vlang.io/) installed on your system

### Instructions

1. Be located on the project root folder

2. Run: 
```bash
v -prod .
```