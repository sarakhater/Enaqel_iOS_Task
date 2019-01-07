//
//  Movie.swift
//  EnaqelTask
//
//  Created by unitlabs on 1/4/19.
//  Copyright © 2019 BestOffer. All rights reserved.
//

import Foundation
import ObjectMapper
import  RealmSwift
import Realm

class Movie : Object, Mappable {
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
      
    }
    @objc dynamic var Title = "";
      @objc dynamic var Year = "";
      @objc dynamic var Rated = ""
      @objc dynamic var Released = "";
    @objc dynamic  var Runtime  = "";
    @objc dynamic  var Genre = "";
    @objc dynamic  var Director = "";
     @objc dynamic var Writer = "";
     @objc dynamic var Actors = "";
     @objc dynamic var Plot = "";
     @objc dynamic var Language = "";
     @objc dynamic var Country = "";
    @objc dynamic  var Awards = "";
    @objc dynamic  var Poster = "";
     @objc dynamic var Metascore = "";
     @objc dynamic var imdbRating = "";
     @objc dynamic var imdbVotes = "";
     @objc dynamic var imdbID = "";
    @objc dynamic   var MovieType = ""
     @objc dynamic  var totalSeasons = ""
    @objc dynamic  var Response = ""
    @objc dynamic  var isFav = false;

    
    
    
   
    required override init() {
        super.init();
      
        //fatalError("init() has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        //fatalError("init(value:schema:) has not been implemented")
        super.init(value: value, schema: schema)
    }
    
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        //fatalError("init(realm:schema:) has not been implemented")
        super.init(realm: realm, schema: schema)
    }
    
  
    override class func primaryKey() -> String? {
        return "Title"
    }
    
    func mapping(map: Map) {
        Title <- map["Title"]
        Year <- map["Year"]
        Rated <- map["Rated"]
         Released <- map["Released"]
         Runtime <- map["Runtime"]
         Genre <- map["Genre"]
        Director <- map["Director"]
        Writer <- map["Writer"]
        Actors <- map["Actors"]
        Plot <- map["Plot"]
        Language <- map["Language"]
        Country <- map["Country"]
        Awards <- map["Awards"]
        Poster <- map["Poster"]
        Metascore <- map["Metascore"]
        imdbRating <- map["imdbRating"]
        imdbVotes <- map["imdbVotes"]
        imdbID <- map["imdbID"]
        MovieType <- map["MovieType"]
        totalSeasons <- map["totalSeasons"]
        Response <- map["Response"]


    }

}
