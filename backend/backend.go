/*
 * Author: Markus Stenberg <fingon@iki.fi>
 *
 * Copyright (c) 2024 Markus Stenberg
 *
 * Created:       Thu Oct  3 11:13:06 2024 mstenber
 * Last modified: Thu Oct  3 12:02:23 2024 mstenber
 * Edit time:     10 min
 *
 */

package backend

import (
	"io"
	"net/http"
	"time"
)

// Async result handler
type ResultHandler interface {
	Error(err string)
	Result(s string)
}

type Backend struct {
	rh ResultHandler
}

func NewBackend(rh ResultHandler) *Backend {
	return &Backend{rh}
}

func (self *Backend) FetchURL(url string) {
	// Intentionally doing this in a goroutine to ensure it will go on
	go func() {
		time.Sleep(1 * time.Second)
		resp, err := http.Get(url)
		if err != nil {
			self.rh.Error(err.Error())
			return
		}
		defer resp.Body.Close()
		body, err := io.ReadAll(resp.Body)
		if err != nil {
			self.rh.Error(err.Error())
			return
		}
		self.rh.Result(string(body))
	}()
}
