//
//  SafariExtensionViewController.swift
//  App Extension
//
//  Created by Simon Whitaker on 14/01/2023.
//

import SafariServices
import SwiftUI

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    @StateObject var websiteDetails = WebsiteDetailsModel()
//    private var contentView: ContentView? = nil

    func setWebsiteTitle(title: String) async {
        websiteDetails.title = title
    }

    static let shared: SafariExtensionViewController = {
        return SafariExtensionViewController()
    }()
    
    override func loadView() {
//        let _contentView = ContentView().environmentObject(websiteDetails) as! ContentView
//        self.contentView = _contentView
        view = NSHostingView(rootView: ContentView().environmentObject(websiteDetails))
    }
}
