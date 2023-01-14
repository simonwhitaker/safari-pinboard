//
//  SafariExtensionHandler.swift
//  App Extension
//
//  Created by Simon Whitaker on 14/01/2023.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
        }
    }

    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("[SW] The extension's toolbar item was clicked")
        window.getActiveTab { tab in
            tab?.getActivePage { page in
                page?.dispatchMessageToScript(withName: "getPageDetails")
            }
        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        NSLog("[SW] popoverViewController() called")
        return SafariExtensionViewController.shared
    }

    override func popoverWillShow(in window: SFSafariWindow) {
        NSLog("[SW] popoverWillShow called")
        Task {
            let tab = await window.activeTab()
            let page = await tab?.activePage()
            let props = await page?.properties()
            NSLog("[SW] Props: \(props?.debugDescription ?? "nil")")
            NSLog("[SW] Title: \(props?.title ?? "nil")")
            NSLog("[SW] URL: \(props?.url?.absoluteString ?? "nil")")
        }
    }
}
