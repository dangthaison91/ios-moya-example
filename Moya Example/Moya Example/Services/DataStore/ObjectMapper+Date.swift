//
//  ObjectMapper+Date.swift
//  actisso
//
//  Created by Pham Anh on 6/29/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import ObjectMapper

class DateTransform: TransformType {
    typealias Object = Date
    typealias JSON = Int
    
    func transformFromJSON(_ value: Any?) -> Date? {
        if let unixTime = value as? Int {
            return Date(timeIntervalSince1970: TimeInterval(unixTime))
        }
        return nil
    }
    
    func transformToJSON(_ value: Date?) -> Int? {
        if let date = value {
            return Int(date.timeIntervalSince1970)
        }
        return nil
    }
}
