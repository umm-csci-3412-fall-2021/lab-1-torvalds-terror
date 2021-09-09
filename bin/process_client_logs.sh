#!/usr/bin/bash

awk 'match($0, /([a-zA-Z 0-9 0-9]+):[0-9]+:[0-9]+ [a-zA-Z_]+ sshd\[[0-9]+\]: Failed password for invalid user ([a-zA-Z0-9]+) from ([0-9.0-9.0-9.0-9]+) port [0-9]+ ssh2/, groups) {print "1. " groups[1] "\n" "2. " groups[2] "\n" print "3. " groups[3] "\n"}' < r0_input.txt > r0_output.txt