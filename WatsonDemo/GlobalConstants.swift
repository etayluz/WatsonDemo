//
//  GlobalConstants.swift
//  WatsonDemo
//
//  Created by Etay Luz on 11/15/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

struct GlobalConstants {
  //  static let dennisNotoBluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
  //  static let dennisNotoBluemixPasswordSTT = "NP0ooxJSFfL8"
  //  static let dennisNotoBluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
  //  static let dennisNotoBluemixPasswordTTS = "DDxOcEN6TIRi"
   
    
#if WATSONBANKASST
    static let dennisNotoWorkspaceID = "1549fa38-7160-4106-82ee-73796b21f3b8"
    static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONINSASST
    static let dennisNotoWorkspaceID = "17df222b-bf8c-41fc-8bec-da21317d993c"
    static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONWEALTHASST
    static let dennisNotoWorkspaceID = "2fb924dd-27c4-4668-8ac3-be7add1065c1"
    static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#elseif WATSONMETASST
    static let dennisNotoWorkspaceID = "5fd7c1c7-9ea2-4fc8-b6fa-7920e10aad5a"
    static let nodeRedWorkflowUrl = "http://metlifepotnode-red1.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "02aa260b-fe3c-428a-83b3-4d6909e305e3"
    static let BluemixPasswordSTT = "5YxEslShK1UL"
    static let BluemixUsernameTTS = "709f9691-5440-4518-ae53-a7515cf2b7eb"
    static let BluemixPasswordTTS = "XY56UTVSd7qB"
    static let TTScustomizationID = "12303bc6-fa08-4ca4-b6aa-8bc4b674e653"
    static let STTcustomizationID = "5a381810-c3a3-11e6-8e67-ada083c78a12"
    
#elseif WATSONWHIRLASST
    static let dennisNotoWorkspaceID = "251c4882-44e3-4f34-9c71-36054e155320"
    static let nodeRedWorkflowUrl = "https://whirlpoolnode-red.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
#else
    static let dennisNotoWorkspaceID = "1549fa38-7160-4106-82ee-73796b21f3b8"
    static let nodeRedWorkflowUrl = "http://nodered-v3.mybluemix.net/mobileV2-1"
    static let BluemixUsernameSTT = "8b772b77-c923-42ff-b2ef-29370cba1965"
    static let BluemixPasswordSTT = "NP0ooxJSFfL8"
    static let BluemixUsernameTTS = "833e48e0-2139-4142-935f-04190b698542"
    static let BluemixPasswordTTS = "DDxOcEN6TIRi"
    static let TTScustomizationID = ""
    static let STTcustomizationID = ""
    
#endif
    
    static let sriniCheedallaBluemixPassword = "Westfield12"
    static let sriniCheedallaBluemixUsername = "scheeda@us.ibm.com"
    static let sriniCheedallaWorkspaceID = "62fb22ec-7163-44a2-b8c9-afd725c234be"
    static let sriniCheedallNodeRedWorkflowUrl = "http://Westfield-Prototype.mybluemix.net/mobileV2-1"
    
    static let etayluzBluemixUsername = "d5e5ca34-f670-4a7f-98c7-1643d83ecc1d"
    static let etayluzBluemixPassword = "N8UAQQPXw10Z"
    
    
}
