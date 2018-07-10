//
//  StringExtension.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import Foundation


extension String {
    
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}
