#!/usr/bin/env python
# http://jonebird.com/2010/11/15/socket-option-defaults/
import socket

s = socket.socket()
socket_options = [ (getattr(socket, opt), opt) for opt in dir(socket) if opt.startswith('SO_') ]
socket_options.sort()
for num, opt in socket_options:
    try:
        val = s.getsockopt(socket.SOL_SOCKET, num)
        print '%s(%d) defaults to %d' % (opt, num, val)
    except (socket.error), e:
        print '%s(%d) can\'t help you out there: %s' % (opt, num, str(e))