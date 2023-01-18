//
//  AddBookmarkView.swift
//  App Extension
//
//  Created by Simon Whitaker on 15/01/2023.
//

import SwiftUI

enum SavingState {
    case none
    case saving
    case success
    case failure
}

struct AddBookmarkView: View {
    @EnvironmentObject var websiteDetails: ViewModel
    var saveHandler: () -> Void
    @State var savingState: SavingState = .none

    func saveBookmark() -> Void {
        savingState = .saving
        Task {
            do {
                try await websiteDetails.save()
                savingState = .success
            } catch {
                savingState = .failure
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()

                if let username = websiteDetails.username() {
                    Text("Logged in as \(username)").font(.caption)
                }
                
                Button("Logout") {
                    websiteDetails.authToken = nil
                }.buttonStyle(.link).font(.caption)
            }

            Text("Add to Pinboard").font(.title)

            TextField("Title", text: $websiteDetails.title).onSubmit(saveBookmark)

            TextField("Description", text: $websiteDetails.description).onSubmit(saveBookmark)

            TextField("Tags (separate with spaces)", text :$websiteDetails.tags).onSubmit(saveBookmark)

            Toggle(isOn: $websiteDetails.isPrivate) {
                Text("Private").font(.caption)
            }

            Toggle(isOn: $websiteDetails.isReadLater) {
                Text("Read Later").font(.caption)
            }

            HStack(spacing: 12.0) {
                Button("Add Bookmark", action: saveBookmark).buttonStyle(.borderedProminent).disabled(savingState != .none)

                if savingState == .saving {
                    ProgressView().controlSize(.small).opacity(savingState == .saving ? 1.0 : 0.0)
                }

                if savingState == .failure || savingState == .success {
                    Image(systemName: savingState == .success ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(savingState == .success ? .green : .red)
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                saveHandler()
                                savingState = .none
                            }
                        }
                }
            }.frame(height: 24)
        }
    }
}

struct AddBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookmarkView() {}
    }
}
