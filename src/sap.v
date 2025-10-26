module main

import net
import os
import time
import rand

fn announce_sdp() ! {
	sap_address := '224.2.127.254:9875'

	mut c := net.dial_udp(sap_address)!

	sdp_file := './stream.sdp'

	mut ip_src_addr := [4]u8{}
	ip_src_addr[0] = 192
	ip_src_addr[1] = 168
	ip_src_addr[2] = 1
	ip_src_addr[3] = 34

	mut base_packet := generate_base_packet(ip_src_addr)

	for {
		mut packet := base_packet[..].clone()

		time.sleep(1 * time.second)

		if !os.exists(sdp_file) {
			base_packet = generate_base_packet(ip_src_addr)
			continue
		}

		sdp_payload := os.read_bytes(sdp_file) or { continue }

		packet << sdp_payload

		c.write(packet) or {}
	}
	
}

fn generate_base_packet(ip_src_addr [4]u8) [24]u8 {
	mut packet := [24]u8{}

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
	packet[0] = vartec

	// auth len: 0
	auth_len := u8(0)
	packet[1] = auth_len

	// msg id hash: random u16 (u8 concat u8)
	packet[2] = rand.u8()
	packet[3] = rand.u8()
	
	// ipv4 address
	packet[4] = ip_src_addr[0]
	packet[5] = ip_src_addr[1]
	packet[6] = ip_src_addr[2]
	packet[7] = ip_src_addr[3]
	
	// Payload type: application/sdp
	mut payload_type := 'application/sdp'.bytes()
	for i, payload_type_byte in payload_type {
		packet[8 + i] = payload_type_byte
	}
	// Append NULL byte (NULL terminated string)
	packet[8 + payload_type.len] = u8(0)
	
	println(packet)
	
	return packet
}
