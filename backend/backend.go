/*
 * Author: Markus Stenberg <fingon@iki.fi>
 *
 * Copyright (c) 2024 Markus Stenberg
 *
 * Created:       Thu Oct  3 11:13:06 2024 mstenber
 * Last modified: Thu Oct  3 11:19:23 2024 mstenber
 * Edit time:     6 min
 *
 */

package backend

import (
	"io"
	"log"
	"net/http"
)

// Async result handler
type ResultHandler interface {
	Result(s string)
}

type Backend struct {
	rh ResultHandler
}

func NewBackend(rh ResultHandler) *Backend {
	return &Backend{rh}
}

func (self *Backend) FetchURL(url string) {
	// Intentionally doing this in a goroutine
	fetch := func() {
		resp, err := http.Get(url)
		if err != nil {
			log.Panic(err)
		}
		defer resp.Body.Close()
		body, err := io.ReadAll(resp.Body)
		if err != nil {
			log.Panic(err)
		}
		self.rh.Result(string(body))
	}
	go fetch()
}
