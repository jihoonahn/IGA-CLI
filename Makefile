install:
	swift build -c release
	install .build/release/gpt-cli /usr/local/bin/gpt
