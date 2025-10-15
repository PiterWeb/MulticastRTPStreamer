module main

fn main() {

	address := "239.255.1.1:5000"

	println("---")
	println("--- Multicast streaming started on: rtp://${address} ---")
	println("---")
	exec(get_command(address, Options.default))

}