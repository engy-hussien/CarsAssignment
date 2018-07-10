//
//  ResultsModel.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import UIKit
import ObjectMapper

class ResultsModel: BaseModel {
    
    var alertEn : String = ""
    var alertAr : String = ""
    var error : [String: Any] = [String: Any]()
    var refreshInterval : Int = 0
    var ticks : String = ""
    var count : Int = 0
    var endDate : Int = 0
    var sortOption : String = ""
    var sortDescription : String = ""
    var cars : [CarModel] = [CarModel]()

    override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        alertEn <- map["alertEn"]
        alertAr <- map["alertAr"]
        error <- map["Error"]
        refreshInterval <- map["RefreshInterval"]
        ticks <- map["Ticks"]
        count <- map["count"]
        endDate <- map["endDate"]
        sortOption <- map["sortOption"]
        sortDescription <- map["sortDirection"]
        cars <- map["Cars"]
    }
}
