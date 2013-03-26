#!/bin/sh

f='/sbin/ipfw -q'

# pipe speed = speed_uplink+(10%->speed_uplink)
${f} pipe 1 config bw 55Mbits queue 10
${f} pipe 2 config bw 55Mbits queue 10

# VIP
${f} queue 1 config pipe 1 weight 70 mask dst-ip 0xffffffff
${f} queue 2 config pipe 2 weight 70 mask src-ip 0xffffffff

# ANY
${f} queue 11 config pipe 1 weight 40 mask dst-ip 0xffffffff
${f} queue 12 config pipe 2 weight 40 mask src-ip 0xffffffff

# inet -> vip
${f} add queue 1 ip from any to "table(10)"

# vip -> inet
${f} add queue 2 ip from "table(10)" to any

# inet -> any
${f} add queue 11 ip from any to not "table(10)"

# any -> inet
${f} add queue 12 ip from not "table(10)" to any


