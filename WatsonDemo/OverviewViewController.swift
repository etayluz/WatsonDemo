
//
//  OverviewViewController.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/13/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    // MARK: - Constants
    private struct Constants {
        static let chatSelectedIndex = 1
    }

    // MARK: - Outlets
    @IBOutlet weak var overviewImageView: UIImageView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSimulator()
       
        #if WATSONBANKASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonBankAsst")
        #elseif WATSONINSASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonInsAsst")
        #elseif WATSONWEALTHASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonWealthAsst")
        #elseif WATSONMETASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonInsAsst")
        #elseif WATSONWHIRLASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonInsAsst")
        #else
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonBankAsst")
        #endif
    
        
        
        // This how you change overiew images - Dennis
        //     overviewImageView.image = #imageLiteral(resourceName: "WestfieldOverview")
        
        
        
    }

    // MARK: - Actions
    @IBAction func goButtonTapped() {
        tabBarController?.selectedIndex = Constants.chatSelectedIndex
    }

    // MARK: - Private
    // This will only execute on the simulator and NOT on a real device
    private func setupSimulator() {
        #if DEBUG
            let when = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.tabBarController?.selectedIndex = Constants.chatSelectedIndex
            }
        #endif
    }

}
