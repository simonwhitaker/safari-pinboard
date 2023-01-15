//
//  SafariExtensionViewController.swift
//  App Extension
//
//  Created by Simon Whitaker on 14/01/2023.
//

import SafariServices
import SwiftUI

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = ViewModel()
        super.init(coder: coder)
    }

//    static let shared: SafariExtensionViewController = {
//        return SafariExtensionViewController()
//    }()
//
    override func loadView() {
        view = NSHostingView(rootView: ContentView(saveHandler: dismissPopover).environmentObject(viewModel))
    }
}
