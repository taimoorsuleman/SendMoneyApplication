//
//  UIStoryboard + Ext.swift
//  TrendingArticles
//
//  Created by Taimoor Suleman on 18/11/2024.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func instantiate<T: UIViewController>(viewControllerType: T.Type, fromStoryboardNamed storyboardName: String, withIdentifier identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Could not instantiate view controller with identifier \(identifier) from storyboard \(storyboardName)")
        }
        return viewController
    }
}
