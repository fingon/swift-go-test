#
# Author: Markus Stenberg <fingon@iki.fi>
#
# Copyright (c) 2024 Markus Stenberg
#
# Created:       Thu Oct  3 11:19:34 2024 mstenber
# Last modified: Thu Oct  3 11:46:38 2024 mstenber
# Edit time:     7 min
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
