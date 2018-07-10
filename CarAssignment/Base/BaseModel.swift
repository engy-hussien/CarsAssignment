//
//  BaseModel.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import UIKit
import ObjectMapper

public class BaseModel: NSObject, Mappable {
    
    // MAKR: Mappable
    override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        super.init()
    }
    
    public func mapping(map: Map) {}
}

