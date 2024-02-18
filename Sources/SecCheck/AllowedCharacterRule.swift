//
//  AllowedCharacterRule.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

import Foundation

/// AllowedCharacterRule checks if the password only has allowed characters.
open class AllowedCharacterRule: PasswordRule {

    open var disallowedCharacters: CharacterSet?

    /// Initialize with an NSCharacterSet object.
    public convenience init(allowedCharacters: CharacterSet) {
        self.init()
        disallowedCharacters = allowedCharacters.inverted
    }

    /// Evaluate password. Return false if it is passed and true if failed.
    open func evaluate(_ password: String) -> Bool {
        guard let disallowedCharacters = disallowedCharacters else {
            return false
        }
        return password.rangeOfCharacter(from: disallowedCharacters) != nil
    }

    /// Error description.
    /// Localization Key - "SECCHECK_ALLOWED_CHARACTER_ERROR"
    open var localizedErrorDescription: String {
        return NSLocalizedString("SECCHECK_ALLOWED_CHARACTER_ERROR", tableName: nil, bundle: Bundle.main, value: "Must not include disallowed character", comment: "SecCheck - Allowed character rule")
    }
}
