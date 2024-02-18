//
//  LengthRule.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

import Foundation

/// LengthRule checks the length of password.
open class LengthRule: PasswordRule {

    open var range: NSRange?

    /// Initialize with minimum and maximum values.
    public convenience init(min: Int, max: Int) {
        self.init()
        range = NSMakeRange(min, max - min + 1)
    }

    /// Evaluate password. Return false if it is passed and true if failed.
    open func evaluate(_ password: String) -> Bool {
        guard let range = range else {
            return false
        }

        return !NSLocationInRange(password.count, range)
    }

    /// Error description.
    /// Localization Key - "SECCHECK_LENGTH_ERROR"
    open var localizedErrorDescription: String {
        var rangeDescription = "nil"

        if let range = range {
            rangeDescription = String(range.lowerBound) + " - " + String(range.upperBound - 1)
        }

        return NSLocalizedString("SECCHECK_LENGTH_ERROR", tableName: nil, bundle: Bundle.main, value: "Must be within range ", comment: "SecCheck - Length rule") + rangeDescription
    }
}
