//
//  ContentView.swift
//  swift-go-test
//
//  Created by Markus Stenberg on 3.10.2024.
//

import Backend
import GRPC
import NIOCore
import NIOPosix
import SwiftUI

struct GlobalBackend {
    static let singleton = GlobalBackend()
    let backend = BackendBackend()
    var fetcher: FetcherAsyncClient
    private init() {
        // This is adapted from HelloWorldClient of grpc-swift examples
        //
        // Setup an `EventLoopGroup` for the connection to run on.
        //
        // See: https://github.com/apple/swift-nio#eventloops-and-eventloopgroups
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        // Configure the channel, we're not using TLS so the connection is `insecure`.
        let channel = try! GRPCChannelPool.with(
            target: .host("localhost", port: backend!.port),
            transportSecurity: .plaintext,
            eventLoopGroup: group
        )

        // Provide the connection to the generated client.
        fetcher = FetcherAsyncClient(channel: channel)
    }
}

struct ContentView: View {
    @State var text = "Nothing fetched, yet"
    var body: some View {
        VStack {
            Text(text)
            Button("Fetch something") {
                print("Fetch started..")
                Task {
                    let fetcher = GlobalBackend.singleton.fetcher

                    // Form the request with the name, if one was provided.
                    let request = URLRequest.with {
                        $0.url = "http://www.fingon.iki.fi"
                    }

                    do {
                        let reply = try await fetcher.fetchURL(request)
                        print("Fetcher received: \(reply.content)")
                        let str = String(decoding: reply.content, as: UTF8.self)
                        self.text = str

                    } catch {
                        print("Fetcher failed: \(error)")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
