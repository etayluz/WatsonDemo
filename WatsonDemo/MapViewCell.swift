//
//  MapViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/21/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation
import UIKit
import WebImage

class MapViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var mapImageView: UIImageView!

    override func prepareForReuse() {
        mapImageView.image = nil
    }

    func configure(withMessage message: Message) {
        if let mapUrl = message.mapUrl {
            mapImageView.sd_setImage(with: mapUrl)
        }
    }
}
