//
//  AddBookmarkView.swift
//  App Extension
//
//  Created by Simon Whitaker on 15/01/2023.
//

import SwiftUI

struct AddBookmarkView: View {
    @EnvironmentObject var websiteDetails: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $websiteDetails.title)

            TextField("Description", text: $websiteDetails.description)

            TextField("Tags (separate with spaces)", text :$websiteDetails.tags)

            Toggle(isOn: $websiteDetails.isPrivate) {
                Text("Private").font(.caption)
            }

            Toggle(isOn: $websiteDetails.isReadLater) {
                Text("Read Later").font(.caption)
            }

            HStack(alignment: .bottom) {
                Button("Save") {
                    Task {
                        do {
                            try await websiteDetails.save()
                        } catch {

                        }
                    }
                }

                Spacer()

                Button("Logout") {
                    websiteDetails.authToken = nil
                }.buttonStyle(.link).font(.caption)
            }
        }
    }
}

struct AddBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookmarkView()
    }
}
