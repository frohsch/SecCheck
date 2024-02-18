// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// Strength of password. There are five levels divided by entropy value.
/// The entropy value is evaluated by infromation entropy theory.
public enum PasswordStrength {
    /// Entropy value is smaller than 28
    case veryWeak
    /// Entropy value is between 28 and 35
    case weak
    /// Entropy value is between 36 and 59
    case reasonable
    /// Entropy value is between 60 and 127
    case strong
    /// Entropy value is larger than 127
    case veryStrong
}

/// Validates strength of passwords.
open class SecCheck {

    /// Gets strength of a password.
    ///
    /// - parameter password: Password string to be calculated
    ///
    /// - returns: Level of strength in PasswordStrength
    public static func strength(ofPassword password: String) -> PasswordStrength {
        return passwordStrength(forEntropy: entropy(of: password))
    }

    /// Converts PasswordStrength to localized string.
    ///
    /// - parameter strength: PasswordStrength to be converted
    ///
    /// - returns: Localized string
    public static func localizedString(forStrength strength: PasswordStrength) -> String {
        switch strength {
        case .veryWeak:
            return NSLocalizedString("SECCHECK_VERY_WEAK", tableName: nil, bundle: Bundle.main, value: "Very Weak", comment: "SecCheck - Very weak")
        case .weak:
            return NSLocalizedString("SECCHECK_WEAK", tableName: nil, bundle: Bundle.main, value: "Weak", comment: "SecCheck - Weak")
        case .reasonable:
            return NSLocalizedString("SECCHECK_REASONABLE", tableName: nil, bundle: Bundle.main, value: "Reasonable", comment: "SecCheck - Reasonable")
        case .strong:
            return NSLocalizedString("SECCHECK_STRONG", tableName: nil, bundle: Bundle.main, value: "Strong", comment: "SecCheck - Strong")
        case .veryStrong:
            return NSLocalizedString("SECCHECK_VERY_STRONG", tableName: nil, bundle: Bundle.main, value: "Very Strong", comment: "SecCheck - Very Strong")
        }
    }

    private static func entropy(of string: String) -> Float {
        guard string.count > 0 else {
            return 0
        }

        var includesLowercaseCharacter = false,
            includesUppercaseCharacter = false,
            includesDecimalDigitCharacter = false,
            includesPunctuationCharacter = false,
            includesSymbolCharacter = false,
            includesWhitespaceCharacter = false,
            includesNonBaseCharacter = false

        var sizeOfCharacterSet: Float = 0

        string.enumerateSubstrings(in: string.startIndex ..< string.endIndex, options: .byComposedCharacterSequences) { subString, _, _, _ in
            guard let unicodeScalars = subString?.first?.unicodeScalars.first else {
                return
            }

            if !includesLowercaseCharacter && CharacterSet.lowercaseLetters.contains(unicodeScalars) {
                includesLowercaseCharacter = true
                sizeOfCharacterSet += 26
            }

            if !includesUppercaseCharacter && CharacterSet.uppercaseLetters.contains(unicodeScalars) {
                includesUppercaseCharacter = true
                sizeOfCharacterSet += 26
            }

            if !includesDecimalDigitCharacter && CharacterSet.decimalDigits.contains(unicodeScalars) {
                includesDecimalDigitCharacter = true
                sizeOfCharacterSet += 10
            }

            if !includesSymbolCharacter && CharacterSet.symbols.contains(unicodeScalars) {
                includesSymbolCharacter = true
                sizeOfCharacterSet += 10
            }

            if !includesPunctuationCharacter && CharacterSet.punctuationCharacters.contains(unicodeScalars) {
                includesPunctuationCharacter = true
                sizeOfCharacterSet += 20
            }

            if !includesWhitespaceCharacter && CharacterSet.whitespacesAndNewlines.contains(unicodeScalars) {
                includesWhitespaceCharacter = true
                sizeOfCharacterSet += 1
            }

            if !includesNonBaseCharacter && CharacterSet.nonBaseCharacters.contains(unicodeScalars) {
                includesNonBaseCharacter = true
                sizeOfCharacterSet += 32 + 128
            }
        }

        return log2f(sizeOfCharacterSet) * Float(string.count)
    }

    private static func passwordStrength(forEntropy entropy: Float) -> PasswordStrength {
        if entropy < 28 {
            return .veryWeak
        } else if entropy < 36 {
            return .weak
        } else if entropy < 60 {
            return .reasonable
        } else if entropy < 128 {
            return .strong
        } else {
            return .veryStrong
        }
    }
}
