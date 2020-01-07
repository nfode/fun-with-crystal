server:
	crystal run src/server.cr
.PHONY: server

listener:
	crystal run src/listener.cr
.PHONY: listener

sender:
	crystal run src/sender.cr
.PHONY: sender
