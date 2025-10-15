module main

enum Options {
	default
	gdigrab
	dshow
}

fn get_command(address string, option Options) string {

	mut ffmpeg_command := 'ffmpeg -hide_banner -nostats -loglevel quiet'
	
	ffmpeg_command += ' '
	
	desktop_src := if option == Options.default || option == Options.gdigrab {
		'-f gdigrab -framerate 30 -offset_x 0 -offset_y 0 -video_size 1920x1080 -i desktop'
	} else if option == Options.dshow {
		'-f dshow -i video="UScreenCapture'
	} else {
		''
	}

	ffmpeg_command += desktop_src
	ffmpeg_command += ' '

	rtp_stream := '-c:v libx264 -preset ultrafast -tune zerolatency -f rtp rtp://${address} -sdp_file ./stream.sdp'

	ffmpeg_command += rtp_stream

	return ffmpeg_command

}