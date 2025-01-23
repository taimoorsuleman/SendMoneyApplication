//
//  Bundle+Localization.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import Foundation
import ObjectiveC

private var bundleKey: UInt8 = 0

extension Bundle {
    
    /// Swaps the main bundle to support dynamic language switching.
    class func setLanguage(_ language: String) {
        objc_setAssociatedObject(Bundle.main, &bundleKey, language, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        // Ensure the bundle is updated
        object_setClass(Bundle.main, CustomBundle.self)
    }
}

private class CustomBundle: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let language = objc_getAssociatedObject(Bundle.main, &bundleKey) as? String,
              let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}
