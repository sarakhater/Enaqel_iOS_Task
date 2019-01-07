//
//  MovieRating.swift
//  EnaqelTask
//
//  Created by unitlabs on 1/4/19.
//  Copyright © 2019 BestOffer. All rights reserved.
//

import Foundation
import  ObjectMapper

class MovieRating : Mappable{
    var Source = "";
    var Value = "";
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        Source <- map["Source"];
        Value <- map["Value"];
    }
}
