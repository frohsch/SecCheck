//
//  PredicateRule.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

import Foundation

/// PredicateRule checks password with a NSPredicate object.
open class PredicateRule: PasswordRule {

    open var predicate: NSPredicate? = nil

    /// Initialize with an NSPredicate object.
    public convenience init(predicate: NSPredicate) {
        self.init()
        self.predicate = predicate
    }

    /// Evaluate password. Return false if it is passed and true if failed.
    open func evaluate(_ password: String) -> Bool {
        guard let predicate = predicate else {
            return false
        }

        return predicate.evaluate(with: password)
    }

    /// Error description.
    /// Localization Key - "SECCHECK_PREDICATE_ERROR"
    open var localizedErrorDescription: String {
        return NSLocalizedString("SECCHECK_PREDICATE_ERROR", tableName: nil, bundle: Bundle.main, value: "Must not match predicate", comment: "SecCheck - Predicate rule")
    }
}
