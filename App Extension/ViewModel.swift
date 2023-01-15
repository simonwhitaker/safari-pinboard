//
//  WebsiteDetails.swift
//  App Extension
//
//  Created by Simon Whitaker on 14/01/2023.
//

import Foundation

final class WebsiteDetailsModel: ObservableObject {
    @Published var url: URL? = URL(string: "https://apple.com/")
    @Published var title: String? = "Xxx"

    func setTitle(title: String) {
        self.title = title
    }
}
