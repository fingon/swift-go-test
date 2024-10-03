//
//  ContentView.swift
//  swift-go-test
//
//  Created by Markus Stenberg on 3.10.2024.
//

import Backend
import SwiftUI

class ResultHandler: NSObject, BackendResultHandlerProtocol {
    var view: ContentView

    init(_ view: ContentView) {
        self.view = view
    }

    func error(_ err: String?) {
        view.text = "Go error occurred: \(err!)"
    }

    func result(_ s: String?) {
        view.text = "Go result: \(s!)"
    }
}

struct ContentView: View {
    @State var text = "Nothing fetched, yet"
    var body: some View {
        VStack {
            Text(text)
            Button("Fetch something") {
                print("Fetch started..")
                let rh = ResultHandler(self)
                let backend = BackendBackend(rh)
                backend!.fetchURL("https://fingon.kapsi.fi")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
