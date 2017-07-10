//
//  EventCell.swift
//  actisso
//
//  Created by Viet Nguyen Tran on 5/29/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftDate

struct EventFeedCellModel {
    let id: Int
    let name: String
    let startTime: Date
    let location: String

    init(event: Event) {
        self.id = event.id
        self.name = event.name
        self.location = event.location
        self.startTime = event.createAt
    }
}

class EventFeedCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setCellModel(_ cellModel: EventFeedCellModel) {
        nameLabel.text = cellModel.name
        timeLabel.text = cellModel.startTime.string(custom: "dd MMM HH:mm")
    }
}
