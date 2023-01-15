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

            HStack(spacing: 12.0) {
                Button("Add Bookmark") {
                    savingState = .saving
                    Task {
                        do {
                            try await websiteDetails.save()
                            savingState = .success
                        } catch {
                            savingState = .failure
                        }
                    }
                }.disabled(savingState != .none)


                if savingState == .saving {
                    ProgressView().controlSize(.small).opacity(savingState == .saving ? 1.0 : 0.0)
                }

                if savingState == .failure || savingState == .success {
                    Image(systemName: savingState == .success ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(savingState == .success ? .green : .red)
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                saveHandler()
                            }
                        }
                }

                Spacer()

                Button("Logout") {
                    websiteDetails.authToken = nil
                }.buttonStyle(.link).font(.caption)
            }.frame(height: 24)
        }
    }
}

struct AddBookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookmarkView() {}
    }
}
