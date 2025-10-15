module main

fn main() {

	address := "224.2.128.0:5000"

	go announce_sdp()

	println("---")
	println("--- Multicast streaming started on: rtp://${address} ---")
	println("---")
	exec(get_command(address, Options.default))

}