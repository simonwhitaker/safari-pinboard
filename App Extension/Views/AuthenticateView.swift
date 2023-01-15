//
//  AuthenticateView.swift
//  App Extension
//
//  Created by Simon Whitaker on 15/01/2023.
//

import SwiftUI

struct AuthenticateView: View {
    @State var authToken: String = ""
    @EnvironmentObject var websiteDetails: ViewModel

    var body: some View {
        HStack {
            SecureField(text: $authToken) {
                Text("Enter your Pinboard API key")
            }
            Button("Save") {
                websiteDetails.authToken = authToken
            }
        }
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView()
    }
}
