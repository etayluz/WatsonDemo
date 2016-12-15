//
//  GlobalConstants.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

struct GlobalConstants {
    static let dennisNotoBluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let dennisNotoBluemixPasswordSTT = "NP0ooxJSFfL8"
    static let dennisNotoBluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let dennisNotoBluemixPasswordTTS = "DDxOcEN6TIRi"
    
    
#if WATSONBANKASST
    static let dennisNotoWorkspaceID = "1549fa38-7160-4106-82ee-73796b21f3b8"
    static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
#elseif WATSONINSASST
    static let dennisNotoWorkspaceID = "17df222b-bf8c-41fc-8bec-da21317d993c"
    static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
#elseif WATSONWEALTHASST
    static let dennisNotoWorkspaceID = "2fb924dd-27c4-4668-8ac3-be7add1065c1"
    static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
#elseif WATSONMETASST
    static let dennisNotoWorkspaceID = "5fd7c1c7-9ea2-4fc8-b6fa-7920e10aad5a"
    static let nodeRedWorkflowUrl = "http://metlifepotnode-red1.mybluemix.net/mobileV2-1"
#else
    static let dennisNotoWorkspaceID = "1549fa38-7160-4106-82ee-73796b21f3b8"
    static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
#endif
    
    static let sriniCheedallaBluemixPassword = "Westfield12"
    static let sriniCheedallaBluemixUsername = "scheeda@us.ibm.com"
    static let sriniCheedallaWorkspaceID = "62fb22ec-7163-44a2-b8c9-afd725c234be"
    static let sriniCheedallNodeRedWorkflowUrl = "http://Westfield-Prototype.mybluemix.net/mobileV2-1"
    
    static let etayluzBluemixUsername = "d5e5ca34-f670-4a7f-98c7-1643d83ecc1d"
    static let etayluzBluemixPassword = "N8UAQQPXw10Z"
    
    
}
