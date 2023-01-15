//
//  WebsiteDetails.swift
//  App Extension
//
//  Created by Simon Whitaker on 14/01/2023.
//

import Foundation
import SwiftPinboard

let server: String = "api.pinboard.in"

final class ViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var urlString: String = ""
    @Published var tags: String = ""
    @Published var description: String = ""
    @Published var isPrivate: Bool = false
    @Published var isReadLater: Bool = false

    @Published var authToken: String? = nil {
        didSet {
            if let authToken = authToken {
                storeAuthTokenInKeychain(authToken: authToken)
            }
        }
    }

    init() {
        self.authToken = loadAuthTokenFromKeychain()
    }

    public func save() async throws {
        let client = PinboardClient(authToken: authToken)

        do {
            try await client.addBookmark(url: self.urlString, title: self.title, description: self.description)
        } catch PinboardClientError.AuthenticationError {
            // TODO: need to log in
            NSLog("[SW] Unauthorised")
        } catch {
            NSLog("[SW] \(error)")
        }
    }

    func storeAuthTokenInKeychain(authToken: String) {
        let authTokenData = authToken.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: server,
            kSecValueData as String: authTokenData
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            self.authToken = authToken
        }
    }

    func loadAuthTokenFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: server,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            return nil
        }
        guard status == errSecSuccess else {
            return nil
        }

        guard let tokenData = item as? Data,
              let token = String(data: tokenData, encoding: String.Encoding.utf8)
        else {
            return nil
        }

        return token
    }
}
