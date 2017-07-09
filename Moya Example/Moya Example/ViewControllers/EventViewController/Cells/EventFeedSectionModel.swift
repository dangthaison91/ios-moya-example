//
//  EventFeedSectionModel.swift
//  actisso
//
//  Created by Pham Anh on 6/15/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import RxDataSources

struct EventFeedSectionModel {
    let header: String
    var events: [EventFeedCellModel]
    
    init(header: String, events: [EventFeedCellModel]) {
        self.header = header
        self.events = events
    }
}

extension EventFeedSectionModel: SectionModelType, AnimatableSectionModelType {
    typealias Item = EventFeedCellModel
    typealias Identity = String
    
    var items: [Item] { return events }
    var identity: String { return header }
    
    init(original: EventFeedSectionModel, items: [Item]) {
        self = original
        self.events = items
    }
}

extension EventFeedCellModel: IdentifiableType, Equatable {
    typealias Itentity = Int
    
    var identity: Int {
        return id.hashValue
    }
}

func ==(lhs: EventFeedCellModel, rhs: EventFeedCellModel) -> Bool {
    return lhs.id == rhs.id
}
