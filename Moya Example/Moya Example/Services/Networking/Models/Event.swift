//
//  MoyaEvent.swift
//  actisso
//
//  Created by Pham Anh on 6/30/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

/** Event Private Information */
import ObjectMapper

class Event {
    
    /** Group ID */
     var id: Int = 0
    
    /** Event Name */
     var name: String = ""
    
    /** Event Description */
     var eventDescription: String = ""
    
    /** True: Public event
     False: Private event */
     var isPublic: Bool = false
    
    /** Event Location */
     var location: String = ""
    
    /** Longitude of location */
     var longitude: Double = 0.0
    
    /** Latitude of location */
     var latitude: Double = 0.0
    
    /** Event time creation in Unix timestamp */
     var createAt: Date = Date()
    
    /** Event start time in Unix timestamp */
     var startAt: Date = Date()
    
    /** Event duration */
     var duration: Double = 0.0
    
    /** Event slot number */
     var slot: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension Event: Mappable {
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        eventDescription <- map["description"]
        isPublic <- map["is_public"]
        location <- map["location"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        createAt <- (map["created_at"], DateTransform())
        startAt <- (map["start_at"], DateTransform())
        duration <- map["duration"]
        slot <- map["slots"]
    }
}
