//
//  ContentView.swift
//  App Extension
//
//  Created by Simon Whitaker on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var websiteDetails: WebsiteDetailsModel

    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("URL: \(websiteDetails.url?.absoluteString ?? "<no url>")")
            Text("Title: \(websiteDetails.title ?? "<no title>")")
        }.padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
