# Swift + Go test app #

This is mostly just an experiment to see what Go backend would look like in a Swift app.

- backend/: Go part of app (Makefile contains relevant utilities to build it)

- swift-go-test/: Swift app

Disclaimer: Speed results are with Macbook Pro (14" 2021 model with M1 Pro)

# How fast is it to build the backend from scratch?

```
mstenber@hana ~/projects/swift-go-test/backend>time make bind
gomobile bind -target ios,iossimulator,macos -o ../swift-go-test/Backend.xcframework
make bind  80.92s user 21.48s system 619% cpu 16.524 total
```

16 seconds

# How fast is incremental compilation? (with disk cache hot)

```
mstenber@hana ~/projects/swift-go-test/backend>echo >> backend.go
mstenber@hana ~/projects/swift-go-test/backend>time make bind
make bind  16.92s user 9.64s system 501% cpu 5.293 total
```

# How big is the result? (3 arches)

Default build

```
mstenber@hana ~/projects/swift-go-test/backend>du -hs ../swift-go-test/Backend.xcframework
 63M	../swift-go-test/Backend.xcframework
```
(of which 25MB mac, 25MB ios-sim, 13MB ios)

With stripped symbols (-ldflags "-s -w")

```
mstenber@hana ~/projects/swift-go-test/backend>du -hs ../swift-go-test/Backend.xcframework
 31M	../swift-go-test/Backend.xcframework
```

# See also

[Rust version](https://github.com/fingon/swift-rust-test)
