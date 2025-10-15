#!/bin/bash

gst-launch-1.0 -v udpsrc port=5000 multicast-group=224.2.128.0 auto-multicast=true ! application/x-rtp,encoding-name=H264 ! rtph264depay ! avdec_h264 ! autovideosink