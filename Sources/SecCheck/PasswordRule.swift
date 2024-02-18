//
//  PasswordRule.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

import Foundation

/// By adopting PasswordRule protocol you can build your own rules.
public protocol PasswordRule {

    /// Evaluating the password
    ///
    /// - parameter password: Password string to be evaluated
    ///
    /// - returns: true is considered to be failed and false is passed.
    func evaluate(_ password: String) -> Bool

    /// Error description
    var localizedErrorDescription: String { get }
}
