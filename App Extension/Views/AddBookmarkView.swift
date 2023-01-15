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
            Text("Title").font(.caption)
            TextField("Title", text: $websiteDetails.title)

            Text("Description").font(.caption)
            TextField("Description", text: $websiteDetails.description)

            Text("Tags (separate with spaces)").font(.caption)
            TextField("Tags", text :$websiteDetails.tags)

            Toggle(isOn: $websiteDetails.isPrivate) {
                Text("Private").font(.caption)
            }

            Toggle(isOn: $websiteDetails.isReadLater) {
                Text("Read Later").font(.caption)
            }

            Button("Save") {
                Task {
                    do {
                        try await websiteDetails.save()
                    } catch {

                    }
                }
            }
            Button("Logout") {
                websiteDetails.authToken = nil
            }
        }
    }
}

struct AddBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookmarkView()
    }
}
