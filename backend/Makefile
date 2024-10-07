#
# Author: Markus Stenberg <fingon@iki.fi>
#
# Copyright (c) 2024 Markus Stenberg
#
# Created:       Thu Oct  3 11:19:34 2024 mstenber
# Last modified: Mon Oct  7 08:18:04 2024 mstenber
# Edit time:     10 min
#
#

# with 'macos' can also build for local dev
TARGET=ios,iossimulator,macos

dep:
	go install golang.org/x/mobile/cmd/gomobile@latest


# TODO: What does this do?
init:
	gomobile init

# After this, Backend.xcframework is created
bind:
	gomobile bind -target $(TARGET) -o ../swift-go-test/Backend.xcframework

# Strip symbols
# -ldflags="-s -w"
