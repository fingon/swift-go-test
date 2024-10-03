#
# Author: Markus Stenberg <fingon@iki.fi>
#
# Copyright (c) 2024 Markus Stenberg
#
# Created:       Thu Oct  3 11:19:34 2024 mstenber
# Last modified: Thu Oct  3 11:29:57 2024 mstenber
# Edit time:     5 min
#
#

dep:
	go install golang.org/x/mobile/cmd/gomobile@latest


# TODO: What does this do?
init:
	gomobile init

# After this, Backend.xcframework is created
bind:
	gomobile bind -target ios,iossimulator -o ../swift-go-test/Backend.xcframework
