//
//  BlockRule.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

import Foundation

/// BlockRule checks password with a block which gets a string and returns a bool value.
open class BlockRule: PasswordRule {

    open var evaluation: ((String) -> Bool)?

    /// Initialize with a Block.
    public convenience init(evaluation: @escaping (String) -> Bool) {
        self.init()
        self.evaluation = evaluation
    }

    /// Evaluate password. Return false if it is passed and true if failed.
    open func evaluate(_ password: String) -> Bool {
        guard let evaluation = evaluation else {
            return false
        }

        return evaluation(password)
    }

    /// Error description.
    /// Localization Key - "SECCHECK_BLOCK_ERROR"
    open var localizedErrorDescription: String {
        return NSLocalizedString("SECCHECK_BLOCK_ERROR", tableName: nil, bundle: Bundle.main, value: "Must not satisfy precondition", comment: "SecCheck - Block rule")
    }
}
