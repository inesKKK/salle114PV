ifconfig | grep "inet[^6]" | grep -v "127.0.0.1" | tr ' ' '\n' | grep 172 | grep -v 255
