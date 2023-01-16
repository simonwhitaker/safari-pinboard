//
//  ContentView.swift
//  Pinboard for Safari
//
//  Created by Simon Whitaker on 14/01/2023.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Start using Pinboard for Safari").font(.title)

            Button("Open Safari Preferences") {
                SFSafariApplication.showPreferencesForExtension(withIdentifier: "org.netcetera.Pinboard-for-Safari.App-Extension")
            }

            Text("Then turn on Add to Pinboard, and click Always Allow on Every Website")

            Spacer()
        }
        .padding()
        .frame(width: 400, height: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
