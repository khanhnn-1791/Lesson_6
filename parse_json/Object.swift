//
//  Object.swift
//  parse_json
//
//  Created by nguyen.nam.khanh on 3/20/19.
//  Copyright © 2019 nguyen.nam.khanh. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Object: Mappable {
    internal var id: String!
    internal var name: String!
    internal var isPrivate: Bool!
    internal var created_at: String!
    internal var avatar_url: String!
    internal var type: String!
    
    init() {}
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        isPrivate <- map["isPrivate"]
        created_at <- map["created_at"]
        avatar_url <- map["owner.avatar_url"]
        type <- map["owner.type"]
    }
}
