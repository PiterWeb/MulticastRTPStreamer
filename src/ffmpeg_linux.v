module main

enum Options {
	default
	x11grab
}

fn get_command(address string, option Options) string {
	if option == Options.default || option == Options.x11grab {
	}

	mut ffmpeg_command := 'sudo ffmpeg -hide_banner -nostats -loglevel quiet'

	ffmpeg_command += ' '

	desktop_src := if option == Options.default || option == Options.x11grab {
		'-f x11grab -show_region 1 -framerate 25 -i :0.0'
	} else {
		''
	}

	ffmpeg_command += desktop_src
	ffmpeg_command += ' '

	rtp_stream := '-c:v libx264 -preset ultrafast -tune zerolatency -f rtp rtp://${address} -sdp_file ./stream.sdp'

	ffmpeg_command += rtp_stream

	return ffmpeg_command
}
