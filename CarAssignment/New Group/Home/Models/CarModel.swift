//
//  CarModel.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import UIKit
import ObjectMapper


class CarModel: BaseModel {
    
    var id : Int = 0
    var image : String = ""
    var arabicDescription : String = ""
    var englishDescription : String = ""
    var imageCount : Int = 0
    var sharingLink : String = ""
    var englishSharingMsg : String = ""
    var arabicSharingMsg : String = ""
    var mileage : String = ""
    var makeID : Int = 0
    var modelID : Int = 0
    var bodyID : Int = 0
    var year = 0
    var englishMake : String = ""
    var arabicMake  : String = ""
    var englishModel : String = ""
    var arabicModel : String = ""
    var englishBody : String = ""
    var arabicBody : String = ""
    var auction : AuctionModel = AuctionModel()
    
    var carName : String {
        if LocalizationManager.currentLanguage == Language.english.rawValue {
            return "\(englishMake) \(englishModel) \(year)"
        }
        return "\(arabicMake) \(arabicModel) \(year)"
    }

    override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["carID"]
        image <- map["image"]
        arabicDescription <- map["descriptionAr"]
        englishDescription <- map["descriptionEn"]
        imageCount <- map["imgCount"]
        sharingLink <- map["sharingLink"]
        englishSharingMsg <- map["sharingMsgEn"]
        arabicSharingMsg <- map["sharingMsgAr"]
        mileage <- map["mileage"]
        makeID <- map["makeID"]
        modelID <- map["modelID"]
        bodyID <- map["bodyId"]
        year <- map["year"]
        englishMake <- map["makeEn"]
        arabicMake <- map["makeAr"]
        arabicModel <- map["modelAr"]
        englishModel <- map["modelEn"]
        englishBody <- map["bodyEn"]
        arabicBody <- map["bodyAr"]
        auction <- map["AuctionInfo"]
    }
}
