//
//  AuctionModel.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import UIKit
import ObjectMapper

class AuctionModel: BaseModel {
    
    var bid : Int = 0
    var endDate : Int = 0
    var arabicEndDate : String = ""
    var englishEndDate : String = ""
    var englishCurrency : String = ""
    var arabicCurrency : String = ""
    var currentPrice : Int = 0
    var minIncrement : Int = 0
    var lot : Int = 0
    var priority : Int = 0
    var VATPercent : Int = 0
    var isModified : Int = 0
    var itemID = 0
    var iCarID : Int = 0
    var iVinNumber  : String = ""
    
    var currency : String {
        if LocalizationManager.currentLanguage == Language.english.rawValue {
            return englishCurrency
        }
        return arabicCurrency
    }
    
    override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        bid <- map["bids"]
        endDate <- map["endDate"]
        englishEndDate <- map["endDateEn"]
        arabicEndDate <- map["endDateAr"]
        englishCurrency <- map["currencyEn"]
        arabicCurrency <- map["currencyAr"]
        currentPrice <- map["currentPrice"]
        minIncrement <- map["minIncrement"]
        lot <- map["lot"]
        priority <- map["priority"]
        VATPercent <- map["VATPercent"]
        isModified <- map["isModified"]
        itemID <- map["itemid"]
        iCarID <- map["iCarId"]
        iVinNumber <- map["iVinNumber"]
    }
}
