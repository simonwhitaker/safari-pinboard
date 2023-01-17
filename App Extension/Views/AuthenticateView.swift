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
        VStack(alignment: .leading) {
            HStack {
                SecureField(text: $authToken) {
                    Text("Enter your Pinboard API Token")
                }.onSubmit {
                    websiteDetails.authToken = authToken
                }
                Button("Save") {
                    websiteDetails.authToken = authToken
                }
            }
            Text("Get your API Token from https://pinboard.in/settings/password").font(.footnote)
        }
    }
}

struct AuthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticateView()
    }
}
