//
//  LocalizationManager.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import Foundation


enum Language : String {
    case arabic = "ar"
    case english = "en"
}

class LocalizationManager : NSObject {
    
    static var currentLanguage: String {
        return Bundle.main.preferredLocalizations.first ?? Language.english.rawValue
    }
        
}
