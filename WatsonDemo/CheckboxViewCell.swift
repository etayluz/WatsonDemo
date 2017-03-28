//
//  CheckboxViewCell.swift
//  WatsonDemo
//
//  Created by Etay Luz on 3/22/17.
//  Copyright © 2017 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

protocol CheckboxViewCellDelegate: NSObjectProtocol {

    // MARK: - Methods
    func continueButtonTapped()
    
}

class CheckboxViewCell: UITableViewCell {

    // MARK: - Outlets


    // MARK: - Properties
    var options: [String]?
    weak var delegate: CheckboxViewCellDelegate!

    /// Configure Watson chat table view cell with Watson message
    ///
    /// - Parameter message: Message instance
    func configure(withMessage message: Message, delegate: CheckboxViewCellDelegate) {
        self.delegate = delegate
        options = message.options
    }

    // MARK: - Actions
    @IBAction func tappedContinueButton() {
        delegate.continueButtonTapped()
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

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let checkboxTableViewCell = tableView.cellForRow(at: indexPath) as! CheckboxTableViewCell
        checkboxTableViewCell.toggleCheckbox()
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let checkboxTableViewCell = tableView.cellForRow(at: indexPath) as! CheckboxTableViewCell
//        checkboxTableViewCell.toggleCheckbox()
//    }

}
