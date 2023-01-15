//
//  ContentView.swift
//  App Extension
//
//  Created by Simon Whitaker on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var websiteDetails: ViewModel

    var body: some View {
        ZStack {
            if websiteDetails.authToken == nil {
                AuthenticateView()
            } else {
                AddBookmarkView()
            }
        }.frame(width: 300).padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewModel())
    }
}
