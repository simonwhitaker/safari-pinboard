//
//  SafariExtensionHandler.swift
//  App Extension
//
//  Created by Simon Whitaker on 14/01/2023.
//

import SafariServices
import SwiftUI

class SafariExtensionHandler: SFSafariExtensionHandler {

    static let viewModel = ViewModel()


    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }

    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }

    override func toolbarItemClicked(in window: SFSafariWindow) {
        // Don't remove this method, or the toolbar item doesn't appear in Safari.
        NSLog("toolbarItemClicked")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController(viewModel: SafariExtensionHandler.viewModel)
    }

    override func popoverWillShow(in window: SFSafariWindow) {
        Task {
            let tab = await window.activeTab()
            let page = await tab?.activePage()
            let props = await page?.properties()

            DispatchQueue.main.async {
                SafariExtensionHandler.viewModel.title = props?.title ?? "unknown"
                SafariExtensionHandler.viewModel.urlString = props?.url?.absoluteString ?? "unknown"
            }
        }
    }
}
