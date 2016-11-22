//
//  MapViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/21/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

class MapViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var mapImageView: UIImageView!


    func configure(withMessage message: Message) {
        if let mapUrl = message.mapUrl {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: mapUrl)
                DispatchQueue.main.async {
                    self.mapImageView.image = UIImage(data: data!)
                }
            }
        }
    }
}
