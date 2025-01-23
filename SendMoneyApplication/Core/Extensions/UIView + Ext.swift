//
//  UIView + Ext.swift
//  TrendingArticles
//
//  Created by Taimoor Suleman on 18/11/2024.
//

import UIKit

// MARK: - UIView Extension for Inspectable Properties

extension UIView {
    
    /// The corner radius of the view's layer.
    ///
    /// This property allows you to set the corner radius directly from Interface Builder.
    /// When set to a value greater than 0, the view's corners will be rounded accordingly.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            // Enables masksToBounds only if cornerRadius is greater than 0
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// The border width of the view's layer.
    ///
    /// This property allows you to set the border width directly from Interface Builder.
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// The border color of the view's layer.
    ///
    /// This property allows you to set the border color directly from Interface Builder.
    /// If set to `nil`, the border color will be removed.
    @IBInspectable var borderColor: UIColor? {
        get {
            // Converts the CGColor to UIColor if it exists
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}
