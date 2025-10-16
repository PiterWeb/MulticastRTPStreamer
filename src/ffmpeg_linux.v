module main

enum Options {
	default
	x11grab
}

fn get_command(address string, option Options) string {

	if option == Options.default || option == Options.x11grab {
		
	}

	return "ffmpeg -f gdigrab -framerate 30 -offset_x 0 -offset_y 0 -video_size 1920x1080 -i desktop -c:v libx264 -preset ultrafast -tune zerolatency -f rtp rtp://${address} -sdp_file ./stream.sdp"

}