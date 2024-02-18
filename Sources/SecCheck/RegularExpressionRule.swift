//
//  RegularExpressionRule.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

import Foundation

/// RegularExpressionRule checks password with a NSRegularExpression object.
open class RegularExpressionRule: PasswordRule {

    open var regularExpression: NSRegularExpression?

    /// Initialize with an NSRegularExpression object.
    public convenience init(regularExpression: NSRegularExpression) {
        self.init()
        self.regularExpression = regularExpression
    }

    /// Evaluate password. Return false if it is passed and true if failed.
    open func evaluate(_ password: String) -> Bool {
        guard let regularExpression = regularExpression else {
            return false
        }

        return regularExpression.numberOfMatches(in: password, options: [], range: NSMakeRange(0, password.count)) > 0
    }

    /// Error description.
    /// Localization Key - "SECCHECK_REGEX_ERROR"
    open var localizedErrorDescription: String {
        return NSLocalizedString("SECCHECK_REGEX_ERROR", tableName: nil, bundle: Bundle.main, value: "Must not match regular expression", comment: "SecCheck - Regex rule")
    }
}
