module main

import net
import os
import time
import rand

fn announce_sdp()! {

	sap_address := "224.2.127.254:9875"

	mut c := net.dial_udp(sap_address)!

	sdp_file := "./stream.sdp"

	mut base_packet := generate_base_packet()

	for {

		mut packet := []u8{}

		packet << base_packet

		time.sleep(1 * time.second)

		if !os.exists(sdp_file) {
			base_packet = generate_base_packet()
			continue
		}

		sdp_payload := os.read_bytes(sdp_file) or { continue }

		packet << sdp_payload

		c.write(packet) or {}
	}

}

fn generate_base_packet() []u8 {

	mut packet := []u8{}

	// Version: SAPv1
	v := u8(0b001) 

	// Address: 0 = IPv4
	a := u8(0b0)

	// Reserved: 0
	r := u8(0b0)

	// Message type: 0 = Announcement
	t := u8(0b0)

	// Encryption: 0
	e := u8(0b0)

	// Compressed: 0
	c := u8(0b0)

	vartec := u8((v << 5) | (a << 4) | (r << 3) | (t << 2) | (e << 1) | c)

	packet << vartec

	// auth len: 0
	auth_len := u8(0)

	packet << auth_len

	// msg id hash: random u16      
	msg_id_hash := [rand.u8(), rand.u8()]

	packet << msg_id_hash

	// ipv4 address
	mut originating_source := []u8{cap: 4}
	originating_source << 192
	originating_source << 168
	originating_source << 1
	originating_source << 34

	packet << originating_source

	// Payload type: application/sdp (NULL terminated string)
	mut payload_type := "application/sdp".bytes()
	// Append NULL byte
	payload_type << 0

	packet << payload_type

	println(packet)

	return packet

}