//
//  Localization.swift
//  LocalizeApp
//
//  Created by Vaifat on 12/19/19.
//  Copyright © 2019 Vaifat. All rights reserved.
//

import UIKit
import Localize_Swift

class Localization {
    private let defaultLanguage: LanguageKey = .english
    private var excludeBase: Bool!
    
    /// Constructor
    /// - Parameter excludeBaseLanguage: Set this property to FALSE if you want to include Base language to available languages' count; Its default value is TRUE
    init(excludeBaseLanguage: Bool = true) { excludeBase = excludeBaseLanguage }
    
    /// Set current language and save to UserDefault
    func setCurrentLanguage(key: LanguageKey) {
        Localize.setCurrentLanguage(key.rawValue)
//        UserDefaults().saveCurrentLanguage(key: key)
//        print("Chosen language: \(UserDefaults().getCurrentLanguage().readableKey)")
        print("Chosen Language: \(Localize.currentLanguage())")
    }
    
    func initilizeLanguage() {
        let chosenLanguage = Localize.currentLanguage()
        Localize.setCurrentLanguage(chosenLanguage)
    }
    
    /// Set current language to default language
    func resetToDefaultLanguage() {
        Localize.setCurrentLanguage(defaultLanguage.rawValue)
    }
    
    /// Set current language with raw language code; The action would be incomplete if the specified code were invalid
    /// - Parameter languageCode: ISO-639 language code
    func setCurrentLanguage(languageCode: String) {
        if let key = LanguageKey.allCases.first(where: {$0.rawValue.contains(languageCode)}) {
            Localize.setCurrentLanguage(key.rawValue)
        }
    }
    
    func convertReableKeyToLanguageKey(readableKey: String) -> LanguageKey? {
        return LanguageKey.allCases.first(where: {return readableKey.contains($0.readableKey)})
    }
    
    func convertCodeToLanguageKey(languageCode: String) -> LanguageKey? {
        return LanguageKey.allCases.first(where: {return languageCode.contains($0.rawValue)})
    }
    
    /// Human readable current language
    var currentLanguage: LanguageKey {
        return LanguageKey.allCases.first(where: {return $0.rawValue == Localize.currentLanguage()}) ?? defaultLanguage
    }
    
    /// Language codes
    var availableLanguageCodes: [String] {
        return Localize.availableLanguages(excludeBase)
    }
    
    /// Human readable language keys
    var readableLanuguageKeys: [String] {
        return LanguageKey.allCases
            .filter { return Localize.availableLanguages(excludeBase).contains($0.rawValue) }
            .map({$0.readableKey})
    }
}

enum LanguageKey: String, CaseIterable{
    case english = "en"
    case chinese = "zh-Hans"
    case khmer = "km-KH"
    case malaysian = "ms"
    case spanish = "es"
    
    var readableKey: String {
        switch self {
        case .english:
            return "English"
        case .chinese:
            return "Chinese"
        case .khmer:
            return "Khmer"
        case .malaysian:
            return "Malaysian"
        case .spanish:
            return "Spanish"
        }
    }
}

