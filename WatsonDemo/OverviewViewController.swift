
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
    struct Constants {
        static let chatSelectedIndex = 1
    }

    // MARK: - Outlets
    @IBOutlet weak var overviewImageView: UIImageView!
    @IBOutlet weak var usecaseButtons: ButtonsView!

    // MARK: - Constraints

    @IBOutlet weak var usecaseButtonsLeadingConstraint: NSLayoutConstraint!

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
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonMetAsst")
        #elseif WATSONWHIRLASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonInsAsst")
        #elseif WATSONFIDASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonWealthAsst")
        #elseif WATSONALFASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonAlfAsst")
            setupUsecaseButtons(withOptions: ["Michael files a claim",
                                              "Michael checks claim status",
                                              "Michael receives proactive claims update"])
        #elseif WATSONREGASST
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonBankAsst")
        #else
            overviewImageView.image = #imageLiteral(resourceName: "Overview-WatsonBankAsst")
        #endif
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

    private func setupUsecaseButtons(withOptions options: [String]) {
        usecaseButtons.configure(withOptions: options,
                                 viewWidth: usecaseButtons.frame.width,
                                 delegate: self)


        // Center buttons
        usecaseButtonsLeadingConstraint.constant = (view.frame.size.width - usecaseButtons.maxX)/2
    }

}


// MARK: - ButtonsViewDelegate
extension OverviewViewController: ButtonsViewDelegate {

    func optionButtonTapped(withSelectedButton selectedButton: CustomButton) {

        if let chatViewController = tabBarController?.viewControllers?[Constants.chatSelectedIndex] as? ChatViewController,
           let option = selectedButton.titleLabel?.text {
            chatViewController.kickoffMessage = option
            tabBarController?.selectedIndex = Constants.chatSelectedIndex
        }

    }
    
}
