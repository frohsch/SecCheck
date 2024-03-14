//
//  DictionaryWordRule.swift
//
//
//  Created by Minjoo Kim on 2/18/24.
//

#if os(OSX)
    import Cocoa
#else
    import UIKit
#endif

/// DictionaryWordRule checks if the password can be found on the OSX or iOS dictionary.
open class DictionaryWordRule: PasswordRule {

    private let nonLowercaseCharacterSet = CharacterSet.lowercaseLetters.inverted
    
    public init() { }

    /// Evaluate password. Return false if it is passed and true if failed.
    open func evaluate(_ password: String) -> Bool {
        #if os(OSX)
            return DCSGetTermRangeInString(nil, password as CFString, 0).location != kCFNotFound
        #else
            return UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: password.lowercased().trimmingCharacters(in: nonLowercaseCharacterSet))
        #endif
    }

    /// Error description.
    /// Localization Key - "SECCHECK_DICTIONARYWORD_ERROR"
    open var localizedErrorDescription: String {
        return NSLocalizedString("SECCHECK_DICTIONARYWORD_ERROR", tableName: nil, bundle: Bundle.main, value: "Must not be dictionary word", comment: "SecCheck - Dictionary word rule")
    }
}
