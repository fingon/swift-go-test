/*
 * Author: Markus Stenberg <fingon@iki.fi>
 *
 * Copyright (c) 2024 Markus Stenberg
 *
 * Created:       Thu Oct  3 11:13:06 2024 mstenber
 * Last modified: Tue Nov 19 16:45:54 2024 mstenber
 * Edit time:     28 min
 *
 */

package backend

import (
	"context"
	"fmt"
	"io"
	"log"
	"net"
	"net/http"

	"fingon.iki.fi/swift-go-test/backend/proto"
	"google.golang.org/grpc"

	_ "golang.org/x/mobile/bind"
)

type server struct {
	proto.UnimplementedFetcherServer
}

func (self *server) FetchURL(_ context.Context, in *proto.URLRequest) (*proto.URLReply, error) {
	url := in.GetUrl()
	log.Printf("Received: %v", url)

	resp, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}
	sbody := string(body)
	return &proto.URLReply{Content: &sbody}, nil
}

type Backend struct {
	server server
	Port   int
}

func NewBackend() *Backend {
	port := 50051
	be := &Backend{Port: port}
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		log.Fatal(err)
	}
	s := grpc.NewServer()
	proto.RegisterFetcherServer(s, &be.server)
	go s.Serve(lis)
	return be
}
