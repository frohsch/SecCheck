//
//  PasswordValidator.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

import Foundation

/// PasswordValidator validates passwords with custom rules.
open class PasswordValidator {

    open var rules: [PasswordRule] = []

    /// PasswordValidator object which checks if the length of password is between 6 and 24.
    public static var standard: PasswordValidator {
        return PasswordValidator(rules: [standardLengthRule])
    }

    /// Length rule having minimum of 6 and maximum of 24.
    public static var standardLengthRule: LengthRule {
        return LengthRule(min: 6, max: 24)
    }

    /// Initialize PasswordValidator with an array of PasswordRule.
    ///
    /// - parameter rules: Password rule(s)
    ///
    /// - returns: Password validator
    public convenience init(rules: [PasswordRule]) {
        self.init()
        self.rules = rules
    }

    /// Executes validation with a password and returns failing rules.
    ///
    /// - parameter password: Password string to be validated
    ///
    /// - returns: Failing rules. nil if all of the rules are passed.
    open func validate(_ password: String) -> [PasswordRule]? {
        var failingRules: [PasswordRule] = []

        for rule in rules {
            if rule.evaluate(password) {
                failingRules.insert(rule, at: failingRules.count)
            }
        }

        if failingRules.count > 0 {
            return failingRules
        } else {
            return nil
        }
    }
}
