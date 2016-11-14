//
//  HomeViewController.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Constants
    private struct Constants {
        static let chatSelectedIndex = 1
    }

    // MARK: - Actions
    @IBAction func goButtonTapped() {
        tabBarController?.selectedIndex = Constants.chatSelectedIndex
    }


}

