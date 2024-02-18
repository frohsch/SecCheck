//
//  RequiredCharacterRule.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

import Foundation

/// RequiredCharacterRulePreset makes initializing RequiredCharacterRule easy.
public enum RequiredCharacterRulePreset {
    /// Password should contain at least one lowercase character.
    case lowercaseCharacter
    /// Password should contain at least one uppercase character.
    case uppercaseCharacter
    /// Password should contain at least one decimal digit character.
    case decimalDigitCharacter
    /// Password should contain at least one symbol character.
    case symbolCharacter
}

/// RequiredCharacterRule checks if the password contains at least one required character.
open class RequiredCharacterRule: PasswordRule {

    private var requiredCharacterSetToCompare: CharacterSet?

    open var requiredCharacterSet: CharacterSet? {
        didSet {
            setRequiredCharacterSet(fromCharacterSet: requiredCharacterSet)
        }
    }

    open var preset: RequiredCharacterRulePreset? {
        didSet {
            setRequiredCharacterSet(fromPreset: preset)
        }
    }

    /// Initialize with an CharacterSet object.
    public convenience init(requiredCharacterSet: CharacterSet) {
        self.init()
        self.requiredCharacterSet = requiredCharacterSet
        setRequiredCharacterSet(fromCharacterSet: requiredCharacterSet)
    }

    /// Initialize with an RequiredCharacterRulePreset.
    public convenience init(preset: RequiredCharacterRulePreset) {
        self.init()
        self.preset = preset
        setRequiredCharacterSet(fromPreset: preset)
    }

    private func setRequiredCharacterSet(fromCharacterSet characterSet: CharacterSet?) {
        guard let requiredCharacterSet = requiredCharacterSet else {
            return
        }

        preset = nil
        requiredCharacterSetToCompare = requiredCharacterSet
    }

    private func setRequiredCharacterSet(fromPreset preset: RequiredCharacterRulePreset?) {
        guard let preset = preset else {
            return
        }

        requiredCharacterSet = nil
        switch preset {
        case .lowercaseCharacter:
            requiredCharacterSetToCompare = CharacterSet.lowercaseLetters
        case .uppercaseCharacter:
            requiredCharacterSetToCompare = CharacterSet.uppercaseLetters
        case .decimalDigitCharacter:
            requiredCharacterSetToCompare = CharacterSet.decimalDigits
        case .symbolCharacter:
            var symbolCharacterSet = CharacterSet.symbols
            symbolCharacterSet.formUnion(CharacterSet.punctuationCharacters)
            requiredCharacterSetToCompare = symbolCharacterSet
        }
    }

    /// Evaluate password. Return false if it is passed and true if failed.
    open func evaluate(_ password: String) -> Bool {
        guard let requiredCharacterSetToCompare = requiredCharacterSetToCompare else {
            return false
        }
        return password.rangeOfCharacter(from: requiredCharacterSetToCompare) == nil
    }

    /// Error description.
    /// Localization keys
    /// - Lowercase error "SECCHECK_REQUIRED_CHARACTER_LOWERCASE_ERROR"
    /// - Uppercase error "SECCHECK_REQUIRED_CHARACTER_UPPERCASE_ERROR"
    /// - Decimal digit error "SECCHECK_REQUIRED_CHARACTER_DECIMAL_DIGIT_ERROR"
    /// - Symbol error "SECCHECK_REQUIRED_CHARACTER_SYMBOL_ERROR"
    /// - Default error "SECCHECK_REQUIRED_CHARACTER_REQUIRED_ERROR"
    open var localizedErrorDescription: String {
        guard let preset = preset else {
            return NSLocalizedString("SECCHECK_REQUIRED_CHARACTER_REQUIRED_ERROR", tableName: nil, bundle: Bundle.main, value: "Must include required characters", comment: "SecCheck - Required character rule")
        }

        switch preset {
        case .lowercaseCharacter:
            return NSLocalizedString("SECCHECK_REQUIRED_CHARACTER_LOWERCASE_ERROR", tableName: nil, bundle: Bundle.main, value: "Must include lowercase characters", comment: "SecCheck - Required lowercase character rule")
        case .uppercaseCharacter:
            return NSLocalizedString("SECCHECK_REQUIRED_CHARACTER_UPPERCASE_ERROR", tableName: nil, bundle: Bundle.main, value: "Must include uppercase characters", comment: "SecCheck - Required uppercase character rule")
        case .decimalDigitCharacter:
            return NSLocalizedString("SECCHECK_REQUIRED_CHARACTER_DECIMAL_DIGIT_ERROR", tableName: nil, bundle: Bundle.main, value: "Must include decimal digit characters", comment: "SecCheck - Required decimal digit character rule")
        case .symbolCharacter:
            return NSLocalizedString("SECCHECK_REQUIRED_CHARACTER_SYMBOL_ERROR", tableName: nil, bundle: Bundle.main, value: "Must include symbol characters", comment: "SecCheck - Required symbol character rule")
        }
    }
}
