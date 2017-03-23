//
//  CheckboxViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 3/22/17.
//  Copyright © 2017 Etay Luz. All rights reserved.
//

import Foundation
import UIKit


class CheckboxViewCell: UITableViewCell {

    // MARK: - Outlets


    // MARK: - Properties
    var options: [String]?


    /// Configure Watson chat table view cell with Watson message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message) {
        options = message.options
    }
    
}


// MARK: - UITableViewDataSource
extension CheckboxViewCell: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let options = options {
            return options.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = options![indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CheckboxTableViewCell.self),
                                                 for: indexPath) as! CheckboxTableViewCell
        cell.configure(withOption: option)
        return cell

    }

}


// MARK: - UITableViewDataSource
extension CheckboxViewCell: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {        
        return 40
    }
    
}
