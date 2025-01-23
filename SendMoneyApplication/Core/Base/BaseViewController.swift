//
//  BaseViewController.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import UIKit

/// A base view controller providing common functionalities to all view controllers in the application.
class BaseViewController: UIViewController {
    /// Called after the view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        enableTapToDismissKeyboard()
        
    }
}
