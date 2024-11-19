#
# Author: Markus Stenberg <fingon@iki.fi>
#
# Copyright (c) 2024 Markus Stenberg
#
# Created:       Thu Oct  3 11:19:34 2024 mstenber
# Last modified: Tue Nov 19 16:10:21 2024 mstenber
# Edit time:     25 min
#
#

# with 'macos' can also build for local dev
TARGET=ios,iossimulator,macos

.PHONY: all
all: dep bind

# Swift GRPC + protobuf, Go grpc + protobuf, gomobile.. plenty of deps
.PHONY: dep
dep:
	brew install swift-protobuf grpc-swift
	go install golang.org/x/mobile/cmd/gomobile@latest
	gomobile init
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# After this, Backend.xcframework is created
.PHONY: bind
bind:
	protoc \
		--go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		--swift_out=../swift-go-test \
		--plugin=protoc-gen-swift-grpc=/opt/homebrew/Cellar/grpc-swift/1.24.2/bin/protoc-gen-grpc-swift \
		--swift-grpc_out=../swift-go-test \
		proto/backend.proto
	gomobile bind \
		-tags=netgo \
		-target $(TARGET) -o ../swift-go-test/Backend.xcframework

# -tags=netgo is needed due to https://github.com/golang/go/issues/58416

# Strip symbols
# -ldflags="-s -w"
